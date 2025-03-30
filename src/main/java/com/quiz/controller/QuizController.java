package com.quiz.controller;

import com.quiz.dto.QuizAnswerDto;
import com.quiz.dto.QuizDto;
import com.quiz.dto.QuizResultDto;
import com.quiz.entity.Category;
import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.QuizResult;
import com.quiz.entity.User;
import com.quiz.service.CategoryService;
import com.quiz.service.QuizResultService;
import com.quiz.service.QuizService;
import com.quiz.service.UserProgressService;
import com.quiz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/quiz")
public class QuizController {

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private QuizService quizService;

    @Autowired
    private QuizResultService quizResultService;

    @Autowired
    private UserProgressService userProgressService;

    private static final int DEFAULT_QUESTIONS_COUNT = 10;

    @GetMapping("/categories")
    public String showCategories(Model model) {
        User currentUser = userService.getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        List<Category> categories = categoryService.findAllCategories();
        Map<Long, Map<String, Boolean>> accessMap = new HashMap<>();  // Changed type here

        // Determine which difficulty levels are accessible for each category
        for (Category category : categories) {
            Map<String, Boolean> levelAccess = new HashMap<>();  // Changed type here

            // Easy is always accessible
            levelAccess.put("EASY", true);

            // Check for MEDIUM and HARD
            boolean mediumAccess = quizService.checkLevelAccess(currentUser.getId(), category.getId(), DifficultyLevel.MEDIUM);
            boolean hardAccess = quizService.checkLevelAccess(currentUser.getId(), category.getId(), DifficultyLevel.HARD);

            levelAccess.put("MEDIUM", mediumAccess);  // Using string key
            levelAccess.put("HARD", hardAccess);      // Using string key

            accessMap.put(category.getId(), levelAccess);
        }

        model.addAttribute("categories", categories);
        model.addAttribute("accessMap", accessMap);
        model.addAttribute("user", currentUser);

        return "quiz/categories";
    }

    @GetMapping("/start")
    public String startQuiz(@RequestParam Long categoryId,
                            @RequestParam DifficultyLevel difficulty,
                            Model model, RedirectAttributes redirectAttributes) {
        User currentUser = userService.getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        try {
            // Check if user has access to this difficulty level
            if (!quizService.checkLevelAccess(currentUser.getId(), categoryId, difficulty)) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "You need to pass the previous level first!");
                return "redirect:/quiz/categories";
            }

            // Get category
            Category category = categoryService.findById(categoryId);

            // Start a quiz
            QuizDto quizDto = quizService.startQuiz(
                    currentUser.getId(), categoryId, difficulty, DEFAULT_QUESTIONS_COUNT);

            model.addAttribute("quiz", quizDto);
            model.addAttribute("category", category);
            model.addAttribute("difficulty", difficulty);
            model.addAttribute("user", currentUser);

            return "quiz/take-quiz";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error starting quiz: " + e.getMessage());
            return "redirect:/quiz/categories";
        }
    }

    @PostMapping("/submit")
    public String submitQuiz(@RequestParam Long categoryId,
                             @RequestParam DifficultyLevel difficulty,
                             @RequestParam Map<String, String> formData,
                             @RequestParam(defaultValue = "0") Long timeTakenSeconds,
                             Model model, RedirectAttributes redirectAttributes) {
        User currentUser = userService.getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        try {
            // Process form data to extract answers
            List<QuizAnswerDto> answers = new ArrayList<>();

            for (Map.Entry<String, String> entry : formData.entrySet()) {
                String key = entry.getKey();
                if (key.startsWith("question_")) {
                    // Extract question ID from the key (format: question_123)
                    Long questionId = Long.parseLong(key.substring("question_".length()));
                    Long selectedOptionId = Long.parseLong(entry.getValue());

                    answers.add(new QuizAnswerDto(questionId, selectedOptionId));
                }
            }

            // Submit quiz and get the result
            QuizResultDto resultDto = quizService.submitQuiz(
                    currentUser.getId(), categoryId, difficulty, answers, timeTakenSeconds);

            // Redirect to result page
            return "redirect:/quiz/result/" + resultDto.getResultId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error submitting quiz: " + e.getMessage());
            return "redirect:/quiz/categories";
        }
    }

    @GetMapping("/result/{resultId}")
    public String showResult(@PathVariable Long resultId, Model model) {
        User currentUser = userService.getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        try {
            QuizResult result = quizResultService.findById(resultId);

            // Verify that the result belongs to the current user
            if (!result.getUser().getId().equals(currentUser.getId())) {
                return "redirect:/access-denied";
            }

            model.addAttribute("result", result);
            model.addAttribute("category", result.getCategory());
            model.addAttribute("difficulty", result.getDifficulty());
            model.addAttribute("user", currentUser);
            model.addAttribute("passingScore", quizService.getPassingScore(result.getDifficulty()));

            return "quiz/result";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error loading result: " + e.getMessage());
            return "error/general";
        }
    }

    @GetMapping("/history")
    public String quizHistory(Model model) {
        User currentUser = userService.getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        List<QuizResult> results = quizResultService.findByUserId(currentUser.getId(), null).getContent();
        model.addAttribute("results", results);
        model.addAttribute("user", currentUser);

        return "quiz/history";
    }

    @GetMapping("/progress")
    public String showProgress(Model model) {
        User currentUser = userService.getCurrentUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        List<Category> categories = categoryService.findAllCategories();
        Map<Long, Map<DifficultyLevel, Integer>> scoresMap = new HashMap<>();
        Map<Long, Map<DifficultyLevel, Boolean>> accessMap = new HashMap<>();

        for (Category category : categories) {
            Map<DifficultyLevel, Integer> categoryScores = new HashMap<>();
            Map<DifficultyLevel, Boolean> categoryAccess = new HashMap<>();

            // Get the highest scores for each difficulty level
            for (DifficultyLevel level : DifficultyLevel.values()) {
                Integer highestScore = userProgressService.getHighestScore(
                        currentUser.getId(), category.getId(), level);
                categoryScores.put(level, highestScore);

                // Check level access
                boolean hasAccess = quizService.checkLevelAccess(
                        currentUser.getId(), category.getId(), level);
                categoryAccess.put(level, hasAccess);
            }

            scoresMap.put(category.getId(), categoryScores);
            accessMap.put(category.getId(), categoryAccess);
        }

        model.addAttribute("categories", categories);
        model.addAttribute("scoresMap", scoresMap);
        model.addAttribute("accessMap", accessMap);
        model.addAttribute("user", currentUser);
        model.addAttribute("difficultyLevels", DifficultyLevel.values());

        return "quiz/progress";
    }
}
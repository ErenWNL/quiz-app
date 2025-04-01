package com.quiz.controller;

import com.quiz.dto.QuestionDto;
import com.quiz.entity.*;
import com.quiz.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private UserProgressService userProgressService;

    @Autowired
    private QuizResultService quizResultService;


    @GetMapping("")
    public String adminHome(Model model) {
        return "admin/home";
    }

    // User Management
    @GetMapping("/users")
    public String listUsers(@RequestParam(defaultValue = "0") int page,
                            @RequestParam(defaultValue = "10") int size,
                            Model model) {
        Page<User> usersPage = userService.findAllUsers(
                PageRequest.of(page, size, Sort.by("id").ascending()));

        model.addAttribute("usersPage", usersPage);
        return "admin/users";
    }

    @GetMapping("/users/{id}")
    public String viewUser(@PathVariable Long id, Model model) {
        User user = userService.findById(id);

        List<UserProgress> progress = userProgressService.findByUserId(id);

        List<QuizResult> results = quizResultService.findByUserId(id, null).getContent();


        model.addAttribute("user", user);
        model.addAttribute("progress", progress);
        model.addAttribute("results", results);
        model.addAttribute("categories", categoryService.findAllCategories());
        return "admin/user-details";
    }

    @PostMapping("/users/{id}/toggle-status")
    public String toggleUserStatus(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        User user = userService.findById(id);
        user.setEnabled(!user.isEnabled());
        userService.updateUser(user);

        String status = user.isEnabled() ? "enabled" : "disabled";
        redirectAttributes.addFlashAttribute("successMessage",
                "User " + user.getUsername() + " has been " + status);

        return "redirect:/admin/users";
    }

    // Category Management
    @GetMapping("/categories")
    public String listCategories(Model model) {
        List<Category> categories = categoryService.findAllCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("newCategory", new Category());
        return "admin/categories";
    }

    @PostMapping("/categories")
    public String createCategory(@Valid @ModelAttribute("newCategory") Category category,
                                 BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.findAllCategories());
            return "admin/categories";
        }

        try {
            categoryService.createCategory(category);
            redirectAttributes.addFlashAttribute("successMessage", "Category created successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating category: " + e.getMessage());
        }

        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/{id}/edit")
    public String editCategoryForm(@PathVariable Long id, Model model) {
        Category category = categoryService.findById(id);
        model.addAttribute("category", category);
        return "admin/edit-category";
    }

    @PostMapping("/categories/{id}")
    public String updateCategory(@PathVariable Long id, @Valid @ModelAttribute("category") Category category,
                                 BindingResult result, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "admin/edit-category";
        }

        try {
            category.setId(id);
            categoryService.updateCategory(category);
            redirectAttributes.addFlashAttribute("successMessage", "Category updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating category: " + e.getMessage());
        }

        return "redirect:/admin/categories";
    }

    @PostMapping("/categories/{id}/delete")
    public String deleteCategory(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            categoryService.deleteCategory(id);
            redirectAttributes.addFlashAttribute("successMessage", "Category deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting category: " + e.getMessage());
        }

        return "redirect:/admin/categories";
    }

    // Question Management
    @GetMapping("/questions")
    public String listQuestions(@RequestParam(required = false) Long categoryId,
                                @RequestParam(required = false) DifficultyLevel difficulty,
                                @RequestParam(defaultValue = "0") int page,
                                @RequestParam(defaultValue = "10") int size,
                                Model model) {
        Page<Question> questionsPage;

        if (categoryId != null && difficulty != null) {
            questionsPage = questionService.findByCategoryIdAndDifficulty(
                    categoryId, difficulty, PageRequest.of(page, size));
        } else if (categoryId != null) {
            questionsPage = questionService.findByCategoryId(
                    categoryId, PageRequest.of(page, size));
        } else if (difficulty != null) {
            questionsPage = questionService.findByDifficulty(
                    difficulty, PageRequest.of(page, size));
        } else {
            questionsPage = questionService.findAllQuestions(PageRequest.of(page, size));
        }

        model.addAttribute("questionsPage", questionsPage);
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("difficulties", DifficultyLevel.values());
        model.addAttribute("selectedCategoryId", categoryId);
        model.addAttribute("selectedDifficulty", difficulty);

        return "admin/questions";
    }

    @GetMapping("/questions/new")
    public String newQuestionForm(Model model) {
        model.addAttribute("questionDto", new QuestionDto());
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("difficulties", DifficultyLevel.values());
        return "admin/create-question";
    }

    @PostMapping("/questions")
    public String createQuestion(@Valid @ModelAttribute("questionDto") QuestionDto questionDto,
                                 BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.findAllCategories());
            model.addAttribute("difficulties", DifficultyLevel.values());
            return "admin/create-question";
        }

        try {
            questionService.createQuestion(questionDto);
            redirectAttributes.addFlashAttribute("successMessage", "Question created successfully");
            return "redirect:/admin/questions";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error creating question: " + e.getMessage());
            model.addAttribute("categories", categoryService.findAllCategories());
            model.addAttribute("difficulties", DifficultyLevel.values());
            return "admin/create-question";
        }
    }

    @GetMapping("/questions/{id}/edit")
    public String editQuestionForm(@PathVariable Long id, Model model) {
        Question question = questionService.findById(id);
        // Convert to DTO
        QuestionDto questionDto = new QuestionDto();
        questionDto.setId(question.getId());
        questionDto.setContent(question.getContent());
        questionDto.setDifficulty(question.getDifficulty());
        questionDto.setCategoryId(question.getCategory().getId());
        questionDto.setExplanation(question.getExplanation());

        model.addAttribute("questionDto", questionDto);
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("difficulties", DifficultyLevel.values());
        return "admin/edit-question";
    }

    @PostMapping("/questions/{id}")
    public String updateQuestion(@PathVariable Long id, @Valid @ModelAttribute("questionDto") QuestionDto questionDto,
                                 BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("categories", categoryService.findAllCategories());
            model.addAttribute("difficulties", DifficultyLevel.values());
            return "admin/edit-question";
        }

        try {
            questionService.updateQuestion(id, questionDto);
            redirectAttributes.addFlashAttribute("successMessage", "Question updated successfully");
            return "redirect:/admin/questions";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating question: " + e.getMessage());
            model.addAttribute("categories", categoryService.findAllCategories());
            model.addAttribute("difficulties", DifficultyLevel.values());
            return "admin/edit-question";
        }
    }

    @PostMapping("/questions/{id}/delete")
    public String deleteQuestion(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            questionService.deleteQuestion(id);
            redirectAttributes.addFlashAttribute("successMessage", "Question deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting question: " + e.getMessage());
        }

        return "redirect:/admin/questions";
    }
}
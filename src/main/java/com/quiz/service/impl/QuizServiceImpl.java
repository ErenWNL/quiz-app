package com.quiz.service.impl;

import com.quiz.dto.OptionDto;
import com.quiz.dto.QuestionDto;
import com.quiz.dto.QuizAnswerDto;
import com.quiz.dto.QuizDto;
import com.quiz.dto.QuizResultDto;
import com.quiz.entity.Category;
import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.Option;
import com.quiz.entity.Question;
import com.quiz.entity.QuizResult;
import com.quiz.entity.User;
import com.quiz.repository.OptionRepository;
import com.quiz.repository.QuizResultRepository;
import com.quiz.service.CategoryService;
import com.quiz.service.QuestionService;
import com.quiz.service.QuizService;
import com.quiz.service.UserProgressService;
import com.quiz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class QuizServiceImpl implements QuizService {

    @Autowired
    private QuestionService questionService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;

    @Autowired
    private UserProgressService userProgressService;

    @Autowired
    private OptionRepository optionRepository;

    @Autowired
    private QuizResultRepository quizResultRepository;

    // Passing scores for each difficulty level
    private static final int EASY_PASSING_SCORE = 60;
    private static final int MEDIUM_PASSING_SCORE = 70;
    private static final int HARD_PASSING_SCORE = 80;

    @Override
    public QuizDto startQuiz(Long userId, Long categoryId, DifficultyLevel difficulty, Integer numQuestions) {
        // Check if user has access to this difficulty level
        if (!checkLevelAccess(userId, categoryId, difficulty)) {
            throw new RuntimeException("You need to pass the previous level first!");
        }

        // Find random questions for the requested category and difficulty
        List<Question> questions = questionService.findRandomQuestionsByCategoryAndDifficulty(
                categoryId, difficulty, numQuestions);

        // Convert to DTOs without correct answer information
        List<QuestionDto> questionDtos = questions.stream().map(question -> {
            QuestionDto dto = new QuestionDto();
            dto.setId(question.getId());
            dto.setContent(question.getContent());

            // Convert options without marking which one is correct
            List<OptionDto> optionDtos = question.getOptions().stream().map(option -> {
                OptionDto optionDto = new OptionDto();
                optionDto.setId(option.getId());
                optionDto.setContent(option.getContent());
                // Don't set isCorrect field for client
                return optionDto;
            }).collect(Collectors.toList());

            dto.setOptions(optionDtos);
            return dto;
        }).collect(Collectors.toList());

        // Create and return the quiz DTO
        QuizDto quizDto = new QuizDto();
        quizDto.setCategoryId(categoryId);
        quizDto.setDifficulty(difficulty);
        quizDto.setQuestions(questionDtos);

        return quizDto;
    }

    @Override
    @Transactional
    public QuizResultDto submitQuiz(Long userId, Long categoryId, DifficultyLevel difficulty,
                                    List<QuizAnswerDto> answers, Long timeTakenSeconds) {
        User user = userService.findById(userId);
        Category category = categoryService.findById(categoryId);

        // Process answers and calculate score
        int correctAnswers = 0;
        int totalQuestions = answers.size();

        // Map to store question IDs and user answers
        Map<Long, Long> userAnswerMap = new HashMap<>();
        for (QuizAnswerDto answer : answers) {
            userAnswerMap.put(answer.getQuestionId(), answer.getSelectedOptionId());
        }

        // Map to store correct answers for each question
        Map<Long, Long> correctAnswerMap = new HashMap<>();
        for (Long questionId : userAnswerMap.keySet()) {
            Option correctOption = optionRepository.findByQuestionIdAndIsCorrect(questionId, true);
            if (correctOption != null) {
                correctAnswerMap.put(questionId, correctOption.getId());
            }
        }

        // Compare user answers with correct answers
        for (Map.Entry<Long, Long> entry : userAnswerMap.entrySet()) {
            Long questionId = entry.getKey();
            Long userSelectedOptionId = entry.getValue();

            if (correctAnswerMap.containsKey(questionId)) {
                Long correctOptionId = correctAnswerMap.get(questionId);
                if (correctOptionId.equals(userSelectedOptionId)) {
                    correctAnswers++;
                }
            }
        }

        // Calculate score as percentage
        int score = totalQuestions > 0 ? (correctAnswers * 100) / totalQuestions : 0;

        // Determine if passed
        int passingScore = getPassingScore(difficulty);
        boolean passed = score >= passingScore;

        // Create quiz result
        QuizResult quizResult = new QuizResult(
                user, category, difficulty, score, totalQuestions, correctAnswers, passed, timeTakenSeconds);

        // Save result
        quizResult = quizResultRepository.save(quizResult);

        // Update user progress if passed
        if (passed) {
            // Update highest score
            userProgressService.updateHighestScore(userId, categoryId, difficulty, score);

            // Unlock next level if available and this is the highest level passed
            if (difficulty == DifficultyLevel.EASY) {
                userProgressService.updateHighestLevelUnlocked(userId, categoryId, DifficultyLevel.MEDIUM);
            } else if (difficulty == DifficultyLevel.MEDIUM) {
                userProgressService.updateHighestLevelUnlocked(userId, categoryId, DifficultyLevel.HARD);
            }
        }

        // Create and return result DTO
        QuizResultDto resultDto = new QuizResultDto();
        resultDto.setResultId(quizResult.getId());
        resultDto.setScore(score);
        resultDto.setTotalQuestions(totalQuestions);
        resultDto.setCorrectAnswers(correctAnswers);
        resultDto.setPassed(passed);
        resultDto.setPassingScore(passingScore);
        resultDto.setTimeTaken(timeTakenSeconds);

        // Add answer feedback
        Map<Long, Boolean> answerCorrectMap = new HashMap<>();
        for (Long questionId : userAnswerMap.keySet()) {
            Long userAnswer = userAnswerMap.get(questionId);
            Long correctAnswer = correctAnswerMap.get(questionId);
            answerCorrectMap.put(questionId, userAnswer.equals(correctAnswer));
        }
        resultDto.setAnswerFeedback(answerCorrectMap);

        return resultDto;
    }

    @Override
    public List<QuizResult> getUserResults(Long userId) {
        return quizResultRepository.findByUserId(userId);
    }

    @Override
    public List<QuizResult> getUserResultsByCategory(Long userId, Long categoryId) {
        return quizResultRepository.findByUserIdAndCategoryId(userId, categoryId);
    }

    @Override
    public QuizResult getResultById(Long resultId) {
        return quizResultRepository.findById(resultId)
                .orElseThrow(() -> new RuntimeException("Result not found with id: " + resultId));
    }

    @Override
    public int getPassingScore(DifficultyLevel difficulty) {
        switch (difficulty) {
            case EASY:
                return EASY_PASSING_SCORE;
            case MEDIUM:
                return MEDIUM_PASSING_SCORE;
            case HARD:
                return HARD_PASSING_SCORE;
            default:
                return EASY_PASSING_SCORE;
        }
    }

    @Override
    public boolean checkLevelAccess(Long userId, Long categoryId, DifficultyLevel difficulty) {
        // Create user progress if it doesn't exist
        userProgressService.createOrUpdateProgress(userId, categoryId);

        // EASY is always accessible
        if (difficulty == DifficultyLevel.EASY) {
            return true;
        }

        // Get highest level unlocked
        DifficultyLevel highestLevel = userProgressService.getHighestLevelUnlocked(userId, categoryId);

        // Check if requested level is unlocked
        return difficulty.ordinal() <= highestLevel.ordinal();
    }
}
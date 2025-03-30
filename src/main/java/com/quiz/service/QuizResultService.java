package com.quiz.service;

import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.QuizResult;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface QuizResultService {

    QuizResult findById(Long id);

    Page<QuizResult> findByUserId(Long userId, Pageable pageable);

    List<QuizResult> findByUserIdAndCategoryId(Long userId, Long categoryId);

    List<QuizResult> findByUserIdAndCategoryIdAndDifficulty(Long userId, Long categoryId, DifficultyLevel difficulty);

    List<QuizResult> findTopScores(Long userId, Long categoryId, DifficultyLevel difficulty, int limit);

    long countPassedQuizzes(Long userId, Long categoryId, DifficultyLevel difficulty);

    QuizResult save(QuizResult quizResult);

    void delete(Long id);
}
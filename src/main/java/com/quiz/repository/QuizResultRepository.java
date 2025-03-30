package com.quiz.repository;

import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.QuizResult;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuizResultRepository extends JpaRepository<QuizResult, Long> {

    List<QuizResult> findByUserId(Long userId);

    Page<QuizResult> findByUserId(Long userId, Pageable pageable);

    List<QuizResult> findByUserIdAndCategoryId(Long userId, Long categoryId);

    List<QuizResult> findByUserIdAndCategoryIdAndDifficulty(Long userId, Long categoryId, DifficultyLevel difficulty);

    @Query("SELECT qr FROM QuizResult qr WHERE qr.user.id = :userId AND qr.category.id = :categoryId AND qr.difficulty = :difficulty ORDER BY qr.score DESC, qr.completionTime DESC")
    List<QuizResult> findTopScoresByUserCategoryAndDifficulty(
            @Param("userId") Long userId,
            @Param("categoryId") Long categoryId,
            @Param("difficulty") DifficultyLevel difficulty,
            Pageable pageable);

    @Query("SELECT COUNT(qr) FROM QuizResult qr WHERE qr.user.id = :userId AND qr.category.id = :categoryId AND qr.difficulty = :difficulty AND qr.passed = true")
    long countPassedQuizzesByUserCategoryAndDifficulty(
            @Param("userId") Long userId,
            @Param("categoryId") Long categoryId,
            @Param("difficulty") DifficultyLevel difficulty);
}
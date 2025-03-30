package com.quiz.repository;

import com.quiz.entity.Category;
import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.Question;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {

    List<Question> findByCategoryAndDifficulty(Category category, DifficultyLevel difficulty);

    @Query("SELECT q FROM Question q WHERE q.category.id = :categoryId AND q.difficulty = :difficulty ORDER BY FUNCTION('RAND')")
    List<Question> findRandomQuestionsByCategoryAndDifficulty(
            @Param("categoryId") Long categoryId,
            @Param("difficulty") DifficultyLevel difficulty,
            Pageable pageable);

    Page<Question> findByCategoryId(Long categoryId, Pageable pageable);

    Page<Question> findByDifficulty(DifficultyLevel difficulty, Pageable pageable);

    Page<Question> findByCategoryIdAndDifficulty(Long categoryId, DifficultyLevel difficulty, Pageable pageable);

    long countByCategoryIdAndDifficulty(Long categoryId, DifficultyLevel difficulty);
}
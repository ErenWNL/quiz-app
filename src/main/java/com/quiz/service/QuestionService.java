package com.quiz.service;

import com.quiz.dto.QuestionDto;
import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.Question;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface QuestionService {

    Question findById(Long id);

    List<Question> findByCategoryAndDifficulty(Long categoryId, DifficultyLevel difficulty);

    List<Question> findRandomQuestionsByCategoryAndDifficulty(Long categoryId, DifficultyLevel difficulty, int count);

    Page<Question> findByCategoryId(Long categoryId, Pageable pageable);

    Page<Question> findByDifficulty(DifficultyLevel difficulty, Pageable pageable);

    Page<Question> findByCategoryIdAndDifficulty(Long categoryId, DifficultyLevel difficulty, Pageable pageable);

    Page<Question> findAllQuestions(Pageable pageable);

    Question createQuestion(QuestionDto questionDto);

    Question updateQuestion(Long id, QuestionDto questionDto);

    void deleteQuestion(Long id);

    long countByCategoryIdAndDifficulty(Long categoryId, DifficultyLevel difficulty);
}
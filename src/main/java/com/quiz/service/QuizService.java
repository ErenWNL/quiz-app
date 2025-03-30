package com.quiz.service;

import com.quiz.dto.QuizAnswerDto;
import com.quiz.dto.QuizDto;
import com.quiz.dto.QuizResultDto;
import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.QuizResult;

import java.util.List;

public interface QuizService {

    QuizDto startQuiz(Long userId, Long categoryId, DifficultyLevel difficulty, Integer numQuestions);

    QuizResultDto submitQuiz(Long userId, Long categoryId, DifficultyLevel difficulty, List<QuizAnswerDto> answers, Long timeTakenSeconds);

    List<QuizResult> getUserResults(Long userId);

    List<QuizResult> getUserResultsByCategory(Long userId, Long categoryId);

    QuizResult getResultById(Long resultId);

    int getPassingScore(DifficultyLevel difficulty);

    boolean checkLevelAccess(Long userId, Long categoryId, DifficultyLevel difficulty);
}
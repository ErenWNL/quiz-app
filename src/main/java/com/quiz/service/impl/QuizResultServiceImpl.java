package com.quiz.service.impl;

import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.QuizResult;
import com.quiz.repository.QuizResultRepository;
import com.quiz.service.QuizResultService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class QuizResultServiceImpl implements QuizResultService {

    @Autowired
    private QuizResultRepository quizResultRepository;

    @Override
    public QuizResult findById(Long id) {
        return quizResultRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Quiz result not found with id: " + id));
    }

    @Override
    public Page<QuizResult> findByUserId(Long userId, Pageable pageable) {
        return quizResultRepository.findByUserId(userId, pageable);
    }

    @Override
    public List<QuizResult> findByUserIdAndCategoryId(Long userId, Long categoryId) {
        return quizResultRepository.findByUserIdAndCategoryId(userId, categoryId);
    }

    @Override
    public List<QuizResult> findByUserIdAndCategoryIdAndDifficulty(Long userId, Long categoryId, DifficultyLevel difficulty) {
        return quizResultRepository.findByUserIdAndCategoryIdAndDifficulty(userId, categoryId, difficulty);
    }

    @Override
    public List<QuizResult> findTopScores(Long userId, Long categoryId, DifficultyLevel difficulty, int limit) {
        return quizResultRepository.findTopScoresByUserCategoryAndDifficulty(
                userId, categoryId, difficulty, PageRequest.of(0, limit));
    }

    @Override
    public long countPassedQuizzes(Long userId, Long categoryId, DifficultyLevel difficulty) {
        return quizResultRepository.countPassedQuizzesByUserCategoryAndDifficulty(userId, categoryId, difficulty);
    }

    @Override
    @Transactional
    public QuizResult save(QuizResult quizResult) {
        return quizResultRepository.save(quizResult);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        quizResultRepository.deleteById(id);
    }
}
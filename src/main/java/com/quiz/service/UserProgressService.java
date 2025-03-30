package com.quiz.service;

import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.UserProgress;

import java.util.List;

public interface UserProgressService {

    UserProgress findByUserIdAndCategoryId(Long userId, Long categoryId);

    List<UserProgress> findByUserId(Long userId);

    UserProgress createOrUpdateProgress(Long userId, Long categoryId);

    boolean updateHighestLevelUnlocked(Long userId, Long categoryId, DifficultyLevel newLevel);

    boolean updateHighestScore(Long userId, Long categoryId, DifficultyLevel level, Integer score);

    boolean hasPassedLevel(Long userId, Long categoryId, DifficultyLevel level);

    DifficultyLevel getHighestLevelUnlocked(Long userId, Long categoryId);

    Integer getHighestScore(Long userId, Long categoryId, DifficultyLevel level);
}
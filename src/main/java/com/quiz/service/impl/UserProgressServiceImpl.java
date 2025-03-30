package com.quiz.service.impl;

import com.quiz.entity.Category;
import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.User;
import com.quiz.entity.UserProgress;
import com.quiz.repository.UserProgressRepository;
import com.quiz.service.CategoryService;
import com.quiz.service.UserProgressService;
import com.quiz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class UserProgressServiceImpl implements UserProgressService {

    @Autowired
    private UserProgressRepository userProgressRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Override
    public UserProgress findByUserIdAndCategoryId(Long userId, Long categoryId) {
        return userProgressRepository.findByUserIdAndCategoryId(userId, categoryId)
                .orElse(null);
    }

    @Override
    public List<UserProgress> findByUserId(Long userId) {
        return userProgressRepository.findByUserId(userId);
    }

    @Override
    @Transactional
    public UserProgress createOrUpdateProgress(Long userId, Long categoryId) {
        Optional<UserProgress> existingProgress = userProgressRepository.findByUserIdAndCategoryId(userId, categoryId);

        if (existingProgress.isPresent()) {
            return existingProgress.get();
        } else {
            User user = userService.findById(userId);
            Category category = categoryService.findById(categoryId);

            UserProgress newProgress = new UserProgress();
            newProgress.setUser(user);
            newProgress.setCategory(category);
            newProgress.setHighestLevelUnlocked(DifficultyLevel.EASY); // Default

            return userProgressRepository.save(newProgress);
        }
    }

    @Override
    @Transactional
    public boolean updateHighestLevelUnlocked(Long userId, Long categoryId, DifficultyLevel newLevel) {
        UserProgress progress = findByUserIdAndCategoryId(userId, categoryId);

        if (progress == null) {
            progress = createOrUpdateProgress(userId, categoryId);
        }

        // Only upgrade level if it's higher than current level
        if (newLevel.ordinal() > progress.getHighestLevelUnlocked().ordinal()) {
            progress.setHighestLevelUnlocked(newLevel);
            userProgressRepository.save(progress);
            return true;
        }

        return false;
    }

    @Override
    @Transactional
    public boolean updateHighestScore(Long userId, Long categoryId, DifficultyLevel level, Integer score) {
        UserProgress progress = findByUserIdAndCategoryId(userId, categoryId);

        if (progress == null) {
            progress = createOrUpdateProgress(userId, categoryId);
        }

        boolean updated = false;

        switch (level) {
            case EASY:
                if (score > progress.getEasyHighestScore()) {
                    progress.setEasyHighestScore(score);
                    updated = true;
                }
                break;
            case MEDIUM:
                if (score > progress.getMediumHighestScore()) {
                    progress.setMediumHighestScore(score);
                    updated = true;
                }
                break;
            case HARD:
                if (score > progress.getHardHighestScore()) {
                    progress.setHardHighestScore(score);
                    updated = true;
                }
                break;
        }

        if (updated) {
            userProgressRepository.save(progress);
        }

        return updated;
    }

    @Override
    public boolean hasPassedLevel(Long userId, Long categoryId, DifficultyLevel level) {
        UserProgress progress = findByUserIdAndCategoryId(userId, categoryId);

        if (progress == null) {
            return false;
        }

        // If the highest unlocked level is greater than or equal to the requested level,
        // it means the user has passed the requested level
        return progress.getHighestLevelUnlocked().ordinal() >= level.ordinal();
    }

    @Override
    public DifficultyLevel getHighestLevelUnlocked(Long userId, Long categoryId) {
        UserProgress progress = findByUserIdAndCategoryId(userId, categoryId);

        if (progress == null) {
            return DifficultyLevel.EASY; // Default
        }

        return progress.getHighestLevelUnlocked();
    }

    @Override
    public Integer getHighestScore(Long userId, Long categoryId, DifficultyLevel level) {
        UserProgress progress = findByUserIdAndCategoryId(userId, categoryId);

        if (progress == null) {
            return 0;
        }

        switch (level) {
            case EASY:
                return progress.getEasyHighestScore();
            case MEDIUM:
                return progress.getMediumHighestScore();
            case HARD:
                return progress.getHardHighestScore();
            default:
                return 0;
        }
    }
}
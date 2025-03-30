package com.quiz.repository;

import com.quiz.entity.Category;
import com.quiz.entity.User;
import com.quiz.entity.UserProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserProgressRepository extends JpaRepository<UserProgress, Long> {

    Optional<UserProgress> findByUserAndCategory(User user, Category category);

    Optional<UserProgress> findByUserIdAndCategoryId(Long userId, Long categoryId);

    List<UserProgress> findByUserId(Long userId);
}
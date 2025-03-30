package com.quiz.service;

import com.quiz.entity.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface CategoryService {

    Category findById(Long id);

    Category findByName(String name);

    List<Category> findAllCategories();

    Page<Category> findAllCategories(Pageable pageable);

    Category createCategory(Category category);

    Category updateCategory(Category category);

    void deleteCategory(Long id);

    boolean existsByName(String name);
}
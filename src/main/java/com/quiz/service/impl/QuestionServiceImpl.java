package com.quiz.service.impl;

import com.quiz.dto.OptionDto;
import com.quiz.dto.QuestionDto;
import com.quiz.entity.Category;
import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.Option;
import com.quiz.entity.Question;
import com.quiz.repository.OptionRepository;
import com.quiz.repository.QuestionRepository;
import com.quiz.service.CategoryService;
import com.quiz.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private OptionRepository optionRepository;

    @Autowired
    private CategoryService categoryService;

    @Override
    public Question findById(Long id) {
        return questionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Question not found with id: " + id));
    }

    @Override
    public List<Question> findByCategoryAndDifficulty(Long categoryId, DifficultyLevel difficulty) {
        Category category = categoryService.findById(categoryId);
        return questionRepository.findByCategoryAndDifficulty(category, difficulty);
    }

    @Override
    public List<Question> findRandomQuestionsByCategoryAndDifficulty(Long categoryId, DifficultyLevel difficulty, int count) {
        return questionRepository.findRandomQuestionsByCategoryAndDifficulty(
                categoryId, difficulty, PageRequest.of(0, count));
    }

    @Override
    public Page<Question> findByCategoryId(Long categoryId, Pageable pageable) {
        return questionRepository.findByCategoryId(categoryId, pageable);
    }

    @Override
    public Page<Question> findByDifficulty(DifficultyLevel difficulty, Pageable pageable) {
        return questionRepository.findByDifficulty(difficulty, pageable);
    }

    @Override
    public Page<Question> findByCategoryIdAndDifficulty(Long categoryId, DifficultyLevel difficulty, Pageable pageable) {
        return questionRepository.findByCategoryIdAndDifficulty(categoryId, difficulty, pageable);
    }

    @Override
    public Page<Question> findAllQuestions(Pageable pageable) {
        return questionRepository.findAll(pageable);
    }

    @Override
    @Transactional
    public Question createQuestion(QuestionDto questionDto) {
        Category category = categoryService.findById(questionDto.getCategoryId());

        Question question = new Question();
        question.setContent(questionDto.getContent());
        question.setDifficulty(questionDto.getDifficulty());
        question.setCategory(category);
        question.setExplanation(questionDto.getExplanation());

        // Save question first to get ID
        question = questionRepository.save(question);

        // Process options
        List<Option> options = new ArrayList<>();
        Long correctOptionId = null;

        for (int i = 0; i < questionDto.getOptions().size(); i++) {
            OptionDto optionDto = questionDto.getOptions().get(i);

            Option option = new Option();
            option.setContent(optionDto.getContent());
            option.setQuestion(question);
            option.setCorrect(optionDto.isCorrect());

            option = optionRepository.save(option);
            options.add(option);

            if (optionDto.isCorrect()) {
                correctOptionId = option.getId();
            }
        }

        // Update question with correct option ID
        question.setCorrectOptionId(correctOptionId);
        question.setOptions(options);
        return questionRepository.save(question);
    }

    @Override
    @Transactional
    public Question updateQuestion(Long id, QuestionDto questionDto) {
        Question question = findById(id);
        Category category = categoryService.findById(questionDto.getCategoryId());

        question.setContent(questionDto.getContent());
        question.setDifficulty(questionDto.getDifficulty());
        question.setCategory(category);
        question.setExplanation(questionDto.getExplanation());

        // Delete existing options
        optionRepository.deleteAll(question.getOptions());

        // Process options
        List<Option> options = new ArrayList<>();
        Long correctOptionId = null;

        for (int i = 0; i < questionDto.getOptions().size(); i++) {
            OptionDto optionDto = questionDto.getOptions().get(i);

            Option option = new Option();
            option.setContent(optionDto.getContent());
            option.setQuestion(question);
            option.setCorrect(optionDto.isCorrect());

            option = optionRepository.save(option);
            options.add(option);

            if (optionDto.isCorrect()) {
                correctOptionId = option.getId();
            }
        }

        // Update question with correct option ID
        question.setCorrectOptionId(correctOptionId);
        question.setOptions(options);
        return questionRepository.save(question);
    }

    @Override
    @Transactional
    public void deleteQuestion(Long id) {
        Question question = findById(id);

        // Delete options first
        optionRepository.deleteAll(question.getOptions());

        // Delete question
        questionRepository.delete(question);
    }

    @Override
    public long countByCategoryIdAndDifficulty(Long categoryId, DifficultyLevel difficulty) {
        return questionRepository.countByCategoryIdAndDifficulty(categoryId, difficulty);
    }
}
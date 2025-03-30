package com.quiz.repository;

import com.quiz.entity.Option;
import com.quiz.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OptionRepository extends JpaRepository<Option, Long> {

    List<Option> findByQuestionId(Long questionId);

    List<Option> findByQuestion(Question question);

    Option findByQuestionIdAndIsCorrect(Long questionId, boolean isCorrect);
}
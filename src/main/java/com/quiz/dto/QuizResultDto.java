package com.quiz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuizResultDto {

    private Long resultId;

    private Integer score;

    private Integer totalQuestions;

    private Integer correctAnswers;

    private Boolean passed;

    private Integer passingScore;

    private Long timeTaken;

    // Map of questionId -> wasCorrect
    private Map<Long, Boolean> answerFeedback = new HashMap<>();
}
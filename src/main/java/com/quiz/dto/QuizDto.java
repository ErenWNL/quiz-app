package com.quiz.dto;

import com.quiz.entity.DifficultyLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuizDto {

    private Long categoryId;

    private DifficultyLevel difficulty;

    private List<QuestionDto> questions = new ArrayList<>();
}
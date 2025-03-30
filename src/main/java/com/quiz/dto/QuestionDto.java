package com.quiz.dto;

import com.quiz.entity.DifficultyLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuestionDto {

    private Long id;

    @NotEmpty(message = "Question content is required")
    @Size(min = 5, max = 500, message = "Question content must be between 5 and 500 characters")
    private String content;

    @NotNull(message = "Difficulty level is required")
    private DifficultyLevel difficulty;

    @NotNull(message = "Category is required")
    private Long categoryId;

    private List<OptionDto> options = new ArrayList<>();

    private String explanation;
}
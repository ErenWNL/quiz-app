package com.quiz.entity;

import lombok.*;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "quiz_results")
@Getter
@Setter
@ToString(exclude = {"user", "category"}) // Exclude lazy-loaded associations
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@NoArgsConstructor
@AllArgsConstructor
public class QuizResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DifficultyLevel difficulty;

    @Column(nullable = false)
    private Integer score;

    @Column(nullable = false)
    private Integer totalQuestions;

    @Column(nullable = false)
    private Integer correctAnswers;

    @Column(name = "completion_time")
    private LocalDateTime completionTime;

    @Column(nullable = false)
    private boolean passed;

    @Column(name = "time_taken_seconds")
    private Long timeTakenSeconds;

    public QuizResult(User user, Category category, DifficultyLevel difficulty,
                      Integer score, Integer totalQuestions, Integer correctAnswers,
                      boolean passed, Long timeTakenSeconds) {
        this.user = user;
        this.category = category;
        this.difficulty = difficulty;
        this.score = score;
        this.totalQuestions = totalQuestions;
        this.correctAnswers = correctAnswers;
        this.completionTime = LocalDateTime.now();
        this.passed = passed;
        this.timeTakenSeconds = timeTakenSeconds;
    }
}
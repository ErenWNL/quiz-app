package com.quiz.config;

import com.quiz.entity.Category;
import com.quiz.entity.DifficultyLevel;
import com.quiz.entity.Option;
import com.quiz.entity.Question;
import com.quiz.entity.Role;
import com.quiz.entity.User;
import com.quiz.repository.CategoryRepository;
import com.quiz.repository.OptionRepository;
import com.quiz.repository.QuestionRepository;
import com.quiz.repository.RoleRepository;
import com.quiz.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private OptionRepository optionRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        // Check if data already exists
        if (roleRepository.count() > 0) {
            return; // Data already initialized
        }

        // Create roles
        Role adminRole = new Role("ADMIN");
        Role userRole = new Role("USER");
        roleRepository.saveAll(Arrays.asList(adminRole, userRole));

        // Create admin and sample user
        User admin = new User();
        admin.setUsername("admin");
        admin.setPassword(passwordEncoder.encode("admin"));
        admin.setEmail("admin@example.com");
        admin.setFullName("Admin User");
        admin.setRoles(new HashSet<>(Arrays.asList(adminRole, userRole)));
        userRepository.save(admin);

        User sampleUser = new User();
        sampleUser.setUsername("user");
        sampleUser.setPassword(passwordEncoder.encode("user"));
        sampleUser.setEmail("user@example.com");
        sampleUser.setFullName("Sample User");
        sampleUser.setRoles(Collections.singleton(userRole));
        userRepository.save(sampleUser);

        // Create categories
        Category pythonCategory = new Category("Python", "Test your Python programming skills");
        Category javaCategory = new Category("Java", "Challenge yourself with Java questions");
        Category cCategory = new Category("C", "Master the fundamentals of C programming");
        categoryRepository.saveAll(Arrays.asList(pythonCategory, javaCategory, cCategory));

        // Create sample questions
        createPythonQuestions(pythonCategory);
        createJavaQuestions(javaCategory);
        createCQuestions(cCategory);
    }

    private void createPythonQuestions(Category pythonCategory) {
        // Python - Easy
        Question q1 = new Question("What is the correct way to declare a variable in Python?", DifficultyLevel.EASY, pythonCategory);
        q1.setExplanation("Python variables do not need explicit declaration or type specification.");
        questionRepository.save(q1);

        Option q1o1 = new Option("var x = 5", q1, false);
        Option q1o2 = new Option("int x = 5", q1, false);
        Option q1o3 = new Option("x = 5", q1, true);
        Option q1o4 = new Option("declare x = 5", q1, false);
        optionRepository.saveAll(Arrays.asList(q1o1, q1o2, q1o3, q1o4));
        q1.setCorrectOptionId(q1o3.getId());
        questionRepository.save(q1);

        Question q2 = new Question("Which of the following is a correct comment in Python?", DifficultyLevel.EASY, pythonCategory);
        q2.setExplanation("Python supports single-line comments using # and multi-line comments using triple quotes.");
        questionRepository.save(q2);

        Option q2o1 = new Option("// This is a comment", q2, false);
        Option q2o2 = new Option("/* This is a comment */", q2, false);
        Option q2o3 = new Option("# This is a comment", q2, true);
        Option q2o4 = new Option("<!-- This is a comment -->", q2, false);
        optionRepository.saveAll(Arrays.asList(q2o1, q2o2, q2o3, q2o4));
        q2.setCorrectOptionId(q2o3.getId());
        questionRepository.save(q2);

        // Python - Medium
        Question q3 = new Question("What is the output of the following code?\n\nx = [1, 2, 3]\ny = x\ny.append(4)\nprint(x)", DifficultyLevel.MEDIUM, pythonCategory);
        q3.setExplanation("In Python, when assigning a list to another variable, both variables point to the same list. Changes to one will affect the other.");
        questionRepository.save(q3);

        Option q3o1 = new Option("[1, 2, 3]", q3, false);
        Option q3o2 = new Option("[1, 2, 3, 4]", q3, true);
        Option q3o3 = new Option("[4, 1, 2, 3]", q3, false);
        Option q3o4 = new Option("Error", q3, false);
        optionRepository.saveAll(Arrays.asList(q3o1, q3o2, q3o3, q3o4));
        q3.setCorrectOptionId(q3o2.getId());
        questionRepository.save(q3);

        // Python - Hard
        Question q4 = new Question("What is the output of the following code?\n\nprint(list(filter(lambda x: x > 5, [2, 4, 6, 8, 10])))", DifficultyLevel.HARD, pythonCategory);
        q4.setExplanation("The filter function returns elements that meet the condition in the lambda function (x > 5).");
        questionRepository.save(q4);

        Option q4o1 = new Option("[6, 8, 10]", q4, true);
        Option q4o2 = new Option("[2, 4]", q4, false);
        Option q4o3 = new Option("[2, 4, 6, 8, 10]", q4, false);
        Option q4o4 = new Option("[]", q4, false);
        optionRepository.saveAll(Arrays.asList(q4o1, q4o2, q4o3, q4o4));
        q4.setCorrectOptionId(q4o1.getId());
        questionRepository.save(q4);
    }

    private void createJavaQuestions(Category javaCategory) {
        // Java - Easy
        Question q1 = new Question("What is the correct way to declare a variable in Java?", DifficultyLevel.EASY, javaCategory);
        q1.setExplanation("Java requires variables to be declared with their type before use.");
        questionRepository.save(q1);

        Option q1o1 = new Option("var x = 5;", q1, false);
        Option q1o2 = new Option("int x = 5;", q1, true);
        Option q1o3 = new Option("x = 5;", q1, false);
        Option q1o4 = new Option("declare x = 5;", q1, false);
        optionRepository.saveAll(Arrays.asList(q1o1, q1o2, q1o3, q1o4));
        q1.setCorrectOptionId(q1o2.getId());
        questionRepository.save(q1);

        // Java - Medium
        Question q2 = new Question("Which collection type allows duplicate elements?", DifficultyLevel.MEDIUM, javaCategory);
        q2.setExplanation("List interface implementations allow duplicate elements, while Set does not.");
        questionRepository.save(q2);

        Option q2o1 = new Option("Set", q2, false);
        Option q2o2 = new Option("Map", q2, false);
        Option q2o3 = new Option("List", q2, true);
        Option q2o4 = new Option("Queue", q2, false);
        optionRepository.saveAll(Arrays.asList(q2o1, q2o2, q2o3, q2o4));
        q2.setCorrectOptionId(q2o3.getId());
        questionRepository.save(q2);

        // Java - Hard
        Question q3 = new Question("What is the output of the following code?\n\nString s1 = \"Java\";\nString s2 = new String(\"Java\");\nSystem.out.println(s1 == s2);", DifficultyLevel.HARD, javaCategory);
        q3.setExplanation("The == operator compares references, not string content. String literals are stored in a string pool, while new String() creates a new object reference.");
        questionRepository.save(q3);

        Option q3o1 = new Option("true", q3, false);
        Option q3o2 = new Option("false", q3, true);
        Option q3o3 = new Option("Compilation error", q3, false);
        Option q3o4 = new Option("Runtime error", q3, false);
        optionRepository.saveAll(Arrays.asList(q3o1, q3o2, q3o3, q3o4));
        q3.setCorrectOptionId(q3o2.getId());
        questionRepository.save(q3);
    }

    private void createCQuestions(Category cCategory) {
        // C - Easy
        Question q1 = new Question("Which of the following is the correct way to declare a variable in C?", DifficultyLevel.EASY, cCategory);
        q1.setExplanation("C requires variables to be declared with their type before use.");
        questionRepository.save(q1);

        Option q1o1 = new Option("var x = 5;", q1, false);
        Option q1o2 = new Option("int x = 5;", q1, true);
        Option q1o3 = new Option("x = 5;", q1, false);
        Option q1o4 = new Option("let x = 5;", q1, false);
        optionRepository.saveAll(Arrays.asList(q1o1, q1o2, q1o3, q1o4));
        q1.setCorrectOptionId(q1o2.getId());
        questionRepository.save(q1);

        // C - Medium
        Question q2 = new Question("What does the sizeof() operator return in C?", DifficultyLevel.MEDIUM, cCategory);
        q2.setExplanation("The sizeof() operator returns the size in bytes of a variable or a data type.");
        questionRepository.save(q2);

        Option q2o1 = new Option("The memory address of a variable", q2, false);
        Option q2o2 = new Option("The value of a variable", q2, false);
        Option q2o3 = new Option("The size in bits of a variable", q2, false);
        Option q2o4 = new Option("The size in bytes of a variable", q2, true);
        optionRepository.saveAll(Arrays.asList(q2o1, q2o2, q2o3, q2o4));
        q2.setCorrectOptionId(q2o4.getId());
        questionRepository.save(q2);

        // C - Hard
        Question q3 = new Question("What is the output of the following code?\n\nint a = 10;\nint b = 20;\nint c = a+++b;\nprintf(\"%d %d %d\", a, b, c);", DifficultyLevel.HARD, cCategory);
        q3.setExplanation("a+++ is parsed as (a++) + b. The value of a is used in the calculation (10+20=30) and then a is incremented to 11.");
        questionRepository.save(q3);

        Option q3o1 = new Option("10 20 30", q3, false);
        Option q3o2 = new Option("11 20 30", q3, true);
        Option q3o3 = new Option("11 20 31", q3, false);
        Option q3o4 = new Option("10 20 31", q3, false);
        optionRepository.saveAll(Arrays.asList(q3o1, q3o2, q3o3, q3o4));
        q3.setCorrectOptionId(q3o2.getId());
        questionRepository.save(q3);
    }
}
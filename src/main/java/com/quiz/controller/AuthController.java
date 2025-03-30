package com.quiz.controller;

import com.quiz.dto.UserRegistrationDto;
import com.quiz.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String login() {
        return "auth/login";
    }

    @GetMapping("/test")
    public String test(Model model) {
        model.addAttribute("message", "Test message");
        return "test";  // Create a simple test.jsp in WEB-INF/views
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new UserRegistrationDto());
        return "auth/register";
    }

    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") UserRegistrationDto userDto,
                               BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        // Check if passwords match
        if (!userDto.getPassword().equals(userDto.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "error.user", "Passwords do not match");
        }

        // Check if username exists
        if (userService.usernameExists(userDto.getUsername())) {
            result.rejectValue("username", "error.user", "Username is already taken");
        }

        // Check if email exists
        if (userService.emailExists(userDto.getEmail())) {
            result.rejectValue("email", "error.user", "Email is already in use");
        }

        if (result.hasErrors()) {
            return "auth/register";
        }

        // Register user
        try {
            userService.registerNewUser(userDto);
            redirectAttributes.addFlashAttribute("successMessage", "Registration successful! Please login.");
            return "redirect:/login";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Registration failed: " + e.getMessage());
            return "auth/register";
        }
    }
}
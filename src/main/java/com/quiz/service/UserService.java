package com.quiz.service;

import com.quiz.dto.UserRegistrationDto;
import com.quiz.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface UserService {

    User registerNewUser(UserRegistrationDto registrationDto);

    User findByUsername(String username);

    User findByEmail(String email);

    User findById(Long id);

    List<User> findAllUsers();

    Page<User> findAllUsers(Pageable pageable);

    User updateUser(User user);

    void deleteUser(Long id);

    boolean usernameExists(String username);

    boolean emailExists(String email);

    User getCurrentUser();
}
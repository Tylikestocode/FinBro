package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.UserAlreadyExistsException;
import com.finbro.FinBroJavaSpring.exception.UserNotFoundException;
import com.finbro.FinBroJavaSpring.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // Check new user details before adding to database
    public void storeUser(User user) {
        validateEmail(user.getEmail());
        checkIfUserExists(user.getUsername());
        user.setPassword(hashPassword(user.getPassword()));
        userRepository.storeUser(user);
    }

    // Get all Users
    public List<User> findAllUsers() {
        return userRepository.findAllUsers();
    }

    // Get User by ID
    public User getUserByID(int userId) {

        User user = userRepository.getUserByID(userId);
        if (user == null) {
            throw new UserNotFoundException("User not found with ID: " + userId);
        }
        return user;
    }

    // Get User by Username
    public User getUserByUsername(String username) {
        User user = userRepository.getUserByUsername(username);
        if (user == null) {
            throw new UserNotFoundException("User not found with Username: " + username);
        }
        return user;
    }


    // Delete user by ID
    public boolean deleteUserByID(int userID) {

        if (userRepository.existsByID(userID)) {
            return userRepository.deleteUserByID(userID);
        }
        return false;

    }


    // HELPER METHODS

    private void validateEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        if (!matcher.matches()) {
            throw new IllegalArgumentException("Invalid email format");
        }
    }

    private void checkIfUserExists(String username) {
        if (userRepository.existsByUsername(username)) {
            throw new UserAlreadyExistsException("Username already exists: " + username);
        }
    }

    private String hashPassword(String password) {
        // Hashing will be done here
        return password;
    }

}

package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.*;
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
        trimStringData(user);
        checkIfUserExists(user.getUsername());
        validateEmail(user.getEmail());
        user.setPassword(hashPassword(user.getPassword()));
        userRepository.storeUser(user);
    }

    // Get all Users
    public List<User> findAllUsers() {
        return userRepository.findAllUsers();
    }

    // Get User by UserID
    public User getUserByID(int userId) {

        if (!userRepository.existsByID(userId)) {
            throw new UserIDNotFoundException(String.valueOf(userId));
        }

        return userRepository.getUserByID(userId);
    }

    // Get User by Username
    public User getUserByUsername(String username) {

        if (!userRepository.existsByUsername(username)) {
            throw new UsernameNotFoundException(username);
        }

        return userRepository.getUserByUsername(username);
    }

    // Update User details
    public void updateUser(User user) {

        if (!userRepository.existsByID(user.getId())) {
            throw new UserIDNotFoundException(String.valueOf(user.getId()));
        }

        User exisitingUser = getUserByID(user.getId());

        // If Username is changing, first check if Username already exists
        if (!exisitingUser.getUsername().equals(user.getUsername())) {
            checkIfUserExists(user.getUsername());
        }

        // If Email is changing, first check if Email is valid
        if (!exisitingUser.getEmail().equals(user.getEmail())){
            validateEmail(user.getEmail());
        }

        // Password hashing to be done here
        // user.setPassword(hashPassword(user.getPassword());
        userRepository.updateUser(user);

    }

    // Delete user by UserID
    public void deleteUserByID(int userID) {

        if (!userRepository.existsByID(userID)) {
            throw new UserIDNotFoundException(String.valueOf(userID));
        }

        if (userRepository.existsByID(userID)) {
            userRepository.deleteUserByID(userID);
        }

    }



    // HELPER METHODS

    private void trimStringData(User user) {

        user.setName(user.getName().trim());
        user.setSurname(user.getSurname().trim());
        user.setUsername(user.getUsername().trim());
        user.setEmail(user.getEmail().trim());

    }

    private void checkIfUserExists(String username) {

        if (userRepository.existsByUsername(username)) {
            throw new UserAlreadyExistsException(username);
        }
    }

    private void validateEmail(String email) {

        if (userRepository.existsByEmail(email)) {
            throw new EmailAlreadyExistsException(email);
        }

        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        if (!matcher.matches()) {
            throw new InvalidEmailFormatException(email);
        }
    }


    private String hashPassword(String password) {
        // Hashing will be done here
        return password;
    }

}

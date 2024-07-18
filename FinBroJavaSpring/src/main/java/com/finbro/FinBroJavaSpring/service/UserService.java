package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.*;
import com.finbro.FinBroJavaSpring.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;
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
        if (usernameExists(user.getUsername())) {
            throw new UserAlreadyExistsException(user.getUsername());
        }
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

        if (!userRepository.userIDExists(userId)) {
            throw new UserIDNotFoundException(String.valueOf(userId));
        }

        return userRepository.getUserByID(userId);
    }

    // Get User by Username
    public User getUserByUsername(String username) {

        if (!userRepository.usernameExists(username)) {
            throw new UsernameNotFoundException(username);
        }

        return userRepository.getUserByUsername(username);
    }

    // Get User by Email
    public User getUserByEmail(String email) {

        if (!userRepository.emailExists(email)) {
            throw new EmailNotFoundException(email);
        }

        return userRepository.getUserByEmail(email);

    }

    // Validate Email and/or Username with Password
    public User validateCredentials(@RequestBody Map<String, String> loginRequest) {

        validateLoginRequest(loginRequest);

        String email = loginRequest.get("email");
        String password = loginRequest.get("password");

        if (!userRepository.emailExists(email)) {
            throw new EmailNotFoundException(email);
        }

        User user = userRepository.getUserByEmail(email);

        if (!password.equals(user.getPassword())) {
            throw new InvalidLoginException("Invalid login details");
        }

        return user;

    }

    // Update User details
    public void updateUser(User user) {

        trimStringData(user);

        if (!userRepository.userIDExists(user.getId())) {
            throw new UserIDNotFoundException(String.valueOf(user.getId()));
        }

        User exisitingUser = getUserByID(user.getId());

        // If Username is changing, first check if Username already exists
        if (!exisitingUser.getUsername().equals(user.getUsername())) {
            usernameExists(user.getUsername());
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

        if (!userRepository.userIDExists(userID)) {
            throw new UserIDNotFoundException(String.valueOf(userID));
        }

        if (userRepository.userIDExists(userID)) {
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

    private boolean usernameExists(String username) {

        return userRepository.usernameExists(username);

    }

    private boolean emailExists(String email) {

        return userRepository.emailExists(email);

    }

    private void validateEmail(String email) {

        if (userRepository.emailExists(email)) {
            throw new EmailAlreadyExistsException(email);
        }

        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        if (!matcher.matches()) {
            throw new InvalidEmailFormatException(email);
        }
    }

    private void validateLoginRequest(Map<String, String> loginRequest) {

        if (!loginRequest.containsKey("email")) {
            throw new MissingParameterException("email");
        }
        if ((!loginRequest.containsKey("password"))) {
            throw new MissingParameterException("password");
        }

    }


    private String hashPassword(String password) {
        // Hashing will be done here
        return password;
    }

}

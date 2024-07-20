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
    public User saveUser(User user) {

        if (user.getId() != null) {
            user.setId(null);
        }

        trimStringData(user);
        if (usernameExists(user.getUsername())) {
            throw new UsernameAlreadyExistsException(user.getUsername());
        }
        validateEmail(user.getEmail());
        user.setPassword(hashPassword(user.getPassword()));

        return userRepository.save(user);

    }

    // Get all Users
    public List<User> findAllUsers() {
        return (List<User>) userRepository.findAll();
    }

    // Get User by UserID
    public User getUserByID(Long userId) {

        if (!userRepository.existsById(userId)) {
            throw new UserIDNotFoundException(String.valueOf(userId));
        }

        return userRepository.findById(userId).orElse(null);
    }

    // Get User by Username
    public User getUserByUsername(String username) {

        if (!userRepository.existsByUsername(username)) {
            throw new UsernameNotFoundException(username);
        }

        return userRepository.findByUsername(username);
    }

    // Get User by Email
    public User getUserByEmail(String email) {

        if (!userRepository.existsByEmail(email)) {
            throw new EmailNotFoundException(email);
        }

        return userRepository.findByEmail(email);

    }

    // Validate Email and/or Username with Password
    public User validateCredentials(@RequestBody Map<String, String> loginRequest) {

        validateUsernamePassword(loginRequest);

        String email = loginRequest.get("email");
        String password = loginRequest.get("password");

        if (!userRepository.existsByEmail(email)) {
            throw new EmailNotFoundException(email);
        }

        User user = userRepository.findByEmail(email);

        if (!password.equals(user.getPassword())) {
            throw new IncorrectPasswordException(loginRequest.get("email"));
        }

        return user;

    }

    // Update User details
    public User updateUser(User user) {

        trimStringData(user);

        if (!userRepository.existsById(user.getId())) {
            throw new UserIDNotFoundException(String.valueOf(user.getId()));
        }

        User exisitingUser = getUserByID(user.getId());

        // If Username is changing, first check if Username already exists
        if (!exisitingUser.getUsername().equals(user.getUsername())) {
            if (usernameExists(user.getUsername())) {
                throw new UsernameAlreadyExistsException(user.getUsername());
            }
        }

        // If Email is changing, first check if Email is valid
        if (!exisitingUser.getEmail().equals(user.getEmail())){
            validateEmail(user.getEmail());
        }

        // Password hashing to be done here
        // user.setPassword(hashPassword(user.getPassword());
        return userRepository.save(user);

    }

    // Delete user by UserID
    public void deleteUserByID(Long id) {

        if (!userRepository.existsById(id)) {
            throw new UserIDNotFoundException(String.valueOf(id));
        }

        userRepository.deleteById(id);

    }



    // HELPER METHODS

    private void trimStringData(User user) {

        user.setName(user.getName().trim());
        user.setSurname(user.getSurname().trim());
        user.setUsername(user.getUsername().trim());
        user.setEmail(user.getEmail().trim());

    }

    private boolean usernameExists(String username) {

        return userRepository.existsByUsername(username);

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

    private void validateUsernamePassword(Map<String, String> loginRequest) {

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

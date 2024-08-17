package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.InvalidDataFormatException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.ResourceAlreadyExistsException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.ResourceNotFoundException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.MissingParameterException;
import com.finbro.FinBroJavaSpring.exception.userexceptions.*;
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



    public User saveUser(User user) {

       validateUser(user, true);

       return userRepository.save(user);

    }

    public List<User> findAllUsers() {
        return (List<User>) userRepository.findAll();
    }

    public User getUserByID(Long userId) {

        if (!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(userId));
        }

        return userRepository.findById(userId).orElse(null);
    }

    public User getUserByUsername(String username) {

        if (!userRepository.existsByUsername(username)) {
            throw new ResourceNotFoundException(User.class, "username", username);
        }

        return userRepository.findByUsername(username);
    }

    public User getUserByEmail(String email) {

        if (!userRepository.existsByEmail(email)) {
            throw new ResourceNotFoundException(User.class, "email", email);
        }

        return userRepository.findByEmail(email);

    }

    public User validateCredentials(@RequestBody Map<String, String> loginRequest) {

        validateUsernamePassword(loginRequest);

        String email = loginRequest.get("email");
        String password = loginRequest.get("password");

        if (!userRepository.existsByEmail(email)) {
            throw new ResourceNotFoundException(User.class, "email", email);
        }

        User user = userRepository.findByEmail(email);

        if (!password.equals(user.getPassword())) {
            throw new IncorrectPasswordException(loginRequest.get("email"));
        }

        return user;

    }

    public User updateUser(User user) {

        validateUser(user, false);

        return userRepository.save(user);

    }

    public void deleteUserByID(Long id) {

        if (!userRepository.existsById(id)) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(id));
        }

        userRepository.deleteById(id);

    }



    // HELPER METHODS

    // All validation happens in one function
    private void validateUser(User user, boolean isNew) {

        // Validation regardless if user is new or not
        trimStringData(user);

        // Validation when adding a new User
        if (isNew) {

            // ID for new User must be null -> database auto generates new ID's
            if (user.getId() != null) {
                user.setId(null);
            }

            validateUsername(user.getUsername());
            validateEmail(user.getEmail());

            user.setPassword(hashPassword(user.getPassword()));
        }
        // Validation when updating an existing User
        else {

            if (!userRepository.existsById(user.getId())) {
                throw new ResourceNotFoundException(User.class, "id", String.valueOf(user.getId()));
            }

            User existingUser = getUserByID(user.getId());

            // If username is changing, first check if username already exists
            if (!existingUser.getUsername().equals(user.getUsername())) {
                validateUsername(user.getUsername());
            }

            // If email is changing, first check if email is valid
            if (!existingUser.getEmail().equals(user.getEmail())) {
                validateEmail(user.getEmail());
            }

            // Password hashing?

        }


    }

    private void trimStringData(User user) {

        user.setName(user.getName().trim());
        user.setSurname(user.getSurname().trim());
        user.setUsername(user.getUsername().trim());
        user.setEmail(user.getEmail().trim());

    }

    private void validateUsername(String username) {

        if (userRepository.existsByUsername(username)) {
            throw new ResourceAlreadyExistsException(User.class, "username", username);
        }

        // Other possible checks in the future

    }

    private void validateEmail(String email) {

        if (userRepository.existsByEmail(email)) {
            throw new ResourceAlreadyExistsException(User.class, "email", email);
        }

        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        if (!matcher.matches()) {
            throw new InvalidDataFormatException("email", email, "name@example.com (must contain '@' and a domain)");
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

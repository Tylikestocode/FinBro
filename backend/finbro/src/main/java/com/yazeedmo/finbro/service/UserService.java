package com.yazeedmo.finbro.service;

import com.yazeedmo.finbro.domain.LoginRequest;
import com.yazeedmo.finbro.domain.User;
import com.yazeedmo.finbro.domain.UserDTO;
import com.yazeedmo.finbro.exception.general.InvalidDataFormatException;
import com.yazeedmo.finbro.exception.general.MissingParameterException;
import com.yazeedmo.finbro.exception.general.ResourceAlreadyExistsException;
import com.yazeedmo.finbro.exception.general.ResourceNotFoundException;
import com.yazeedmo.finbro.exception.user.IncorrectPasswordException;
import com.yazeedmo.finbro.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@SuppressWarnings("BooleanMethodIsAlwaysInverted")
@Service
public class UserService {

    private final UserRepository userRepository;

    @Lazy
    private final AccountService accountService;
    @Lazy
    private final TransactionService transactionService;
    @Lazy
    private final CategoryService categoryService;
    @Lazy
    private final RegularPaymentService regularPaymentService;
    @Lazy
    private final GmailService gmailService;

    @Autowired
    public UserService(
            UserRepository userRepository,
            @Lazy AccountService accountService,
            @Lazy TransactionService transactionService,
            @Lazy CategoryService categoryService,
            @Lazy RegularPaymentService regularPaymentService,
            @Lazy GmailService gmailService
    ) {
        this.userRepository = userRepository;
        this.accountService = accountService;
        this.transactionService = transactionService;
        this.categoryService = categoryService;
        this.regularPaymentService = regularPaymentService;
        this.gmailService = gmailService;
    }


    public User createUser(User user) {

       validateUser(user, true);

       User newUser = userRepository.save(user);

       try {
           gmailService.sendWelcomeEmail(user.getEmail());
       }
       catch (Exception e) {
           System.out.println("Something happened while trying to send an email");
           e.printStackTrace();
       }

       return newUser;

    }

    public List<User> getAllUsers() {
        return (List<User>) userRepository.findAll();
    }

    public User getUserById(Long userId) {

        if (!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(userId));
        }

        return userRepository.findById(userId).orElse(null);
    }

    public boolean existsById(Long userId) {
        return userRepository.existsById(userId);
    }

    public UserDTO getUserWithDetails (Long userId) {

        UserDTO userDTO = new UserDTO();

        userDTO.setUser(this.getUserById(userId));
        userDTO.setAccounts(accountService.getAllByUserId(userId));
        userDTO.setTransactions(transactionService.getAllByUserId(userId));
        userDTO.setCategories(categoryService.getAllByUserId(userId));
        userDTO.setRegularPayments(regularPaymentService.getAllByUserId(userId));

        return userDTO;

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

    public User validateCredentials(@RequestBody LoginRequest loginRequest) {

        if (loginRequest.getEmail() == null) {
            throw new MissingParameterException("email");
        }
        if (loginRequest.getPassword() == null) {
            throw new MissingParameterException("password");
        }

        if (!userRepository.existsByEmail(loginRequest.getEmail())) {
            throw new ResourceNotFoundException(User.class, "email", loginRequest.getEmail());
        }

        User user = userRepository.findByEmail(loginRequest.getEmail());

        if (!loginRequest.getPassword().equals(user.getPassword())) {
            throw new IncorrectPasswordException(loginRequest.getEmail());
        }

        System.out.println(user);

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

            User existingUser = getUserById(user.getId());

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


    private String hashPassword(String password) {
        // Hashing will be done here
        return password;
    }

}

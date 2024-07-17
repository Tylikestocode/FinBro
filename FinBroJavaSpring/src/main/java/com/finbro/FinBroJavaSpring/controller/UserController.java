package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.ErrorResponse;
import com.finbro.FinBroJavaSpring.exception.UserAlreadyExistsException;
import com.finbro.FinBroJavaSpring.exception.UserNotFoundException;
import com.finbro.FinBroJavaSpring.repository.UserRepository;
import com.finbro.FinBroJavaSpring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "http://localhost")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }



    @PostMapping("/addUser")
    public ResponseEntity<?> addUser(@RequestBody User user) {
        try {
            userService.storeUser(user);
            return ResponseEntity.status(HttpStatus.CREATED).body(user);
        }
        catch (IllegalArgumentException | UserAlreadyExistsException e) {
            ErrorResponse errorResponse = new ErrorResponse(HttpStatus.BAD_REQUEST.value(), e.getMessage(), System.currentTimeMillis());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
        }
    }

    @GetMapping("/allUsers")
    public List<User> getUsers(Model page) {
        return userService.findAllUsers();
    }

    @GetMapping("/getByUserId/{userId}")
    public ResponseEntity<?> getUserByID(@PathVariable int userId) {
        try {
            User user = userService.getUserByID(userId);
            return ResponseEntity.ok(user);
        }
        catch (UserNotFoundException | EmptyResultDataAccessException e) {
            ErrorResponse errorResponse = new ErrorResponse(HttpStatus.NOT_FOUND.value(), "User not found with ID: " + userId, System.currentTimeMillis());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
    }

    @GetMapping("/getByUsername/{username}")
    public ResponseEntity<?> getUserByUsername(@PathVariable String username) {
        try {
            User user = userService.getUserByUsername(username);
            return ResponseEntity.ok(user);
        }
        catch (UserNotFoundException | EmptyResultDataAccessException e) {
            ErrorResponse errorResponse = new ErrorResponse(HttpStatus.NOT_FOUND.value(), "User not found with Username: " + username, System.currentTimeMillis());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
    }

    @PutMapping("/updateUser")
    public ResponseEntity<?> updateUser(@RequestBody User user) {
        try {
            boolean updated = userService.updateUser(user);
            if (updated) {
                return ResponseEntity.ok(user);
            }
            else {
                ErrorResponse errorResponse = new ErrorResponse(
                        HttpStatus.NOT_FOUND.value(),
                        "User not found with ID: " + user.getId(),
                        System.currentTimeMillis());
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
            }
        }
        catch (IllegalArgumentException | UserNotFoundException e) {
            ErrorResponse errorResponse = new ErrorResponse(
                    HttpStatus.BAD_REQUEST.value(),
                    e.getMessage(),
                    System.currentTimeMillis()
            );
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
        catch (UserAlreadyExistsException e) {
            ErrorResponse errorResponse = new ErrorResponse(
                    HttpStatus.CONFLICT.value(),
                    e.getMessage(),
                    System.currentTimeMillis()
            );
            return ResponseEntity.status(HttpStatus.CONFLICT).body(errorResponse);
        }
    }

    @DeleteMapping("/deleteByUserId/{userId}")
    public ResponseEntity<?> deleteUserById(@PathVariable int userId) {
        boolean deleted = userService.deleteUserByID(userId);
        if (deleted) {
            return ResponseEntity.noContent().build();
        }
        else {
            ErrorResponse errorResponse = new ErrorResponse(HttpStatus.NOT_FOUND.value(), "User not found with ID: " + userId, System.currentTimeMillis());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
    }

}

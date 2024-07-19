package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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

        User savedUser = userService.saveUser(user);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(savedUser);

    }

    @GetMapping("/allUsers")
    public List<User> getUsers(Model page) {
        return userService.findAllUsers();
    }

    @GetMapping("/getByUserId/{userId}")
    public ResponseEntity<?> getUserByID(@PathVariable int userId) {

        User user = userService.getUserByID(userId);
        return ResponseEntity.ok(user);

    }

    @GetMapping("/getByUsername/{username}")
    public ResponseEntity<?> getUserByUsername(@PathVariable String username) {

        User user = userService.getUserByUsername(username);
        return ResponseEntity.ok(user);

    }

    @GetMapping("/getByEmail/{email}")
    public ResponseEntity<?> getUserByEmail(@PathVariable String email) {

        User user = userService.getUserByEmail(email);
        return ResponseEntity.ok(user);

    }

    @GetMapping("/validateCredentials")
    public ResponseEntity<?> validateCredentials(@RequestBody Map<String, String> loginRequest) {

        User user = userService.validateCredentials(loginRequest);
        return ResponseEntity.ok(user);

    }

    @PutMapping("/updateUser")
    public ResponseEntity<?> updateUser(@RequestBody User user) {

        User updatedUser = userService.updateUser(user);
        return ResponseEntity
                .status(HttpStatus.ACCEPTED)
                .body(updatedUser);

    }

    @DeleteMapping("/deleteByUserId/{userId}")
    public ResponseEntity<?> deleteUserById(@PathVariable int userId) {

        userService.deleteUserByID(userId);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body("User successfully deleted");

    }

}

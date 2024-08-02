package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.ApiResponse;
import com.finbro.FinBroJavaSpring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<ApiResponse<User>> addUser(@RequestBody User user) {

        User savedUser = userService.saveUser(user);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(new ApiResponse<>(true, savedUser));

    }

    @GetMapping("/allUsers")
    public ResponseEntity<ApiResponse<List<User>>> getUsers() {

        List<User> allUsers =  userService.findAllUsers();

        ApiResponse<List<User>> apiResponse = new ApiResponse<>(true, allUsers);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

    @GetMapping("/getByUserId/{userId}")
    public ResponseEntity<ApiResponse<User>> getUserByID(@PathVariable int userId) {

        User user = userService.getUserByID((long) userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @GetMapping("/getByUsername/{username}")
    public ResponseEntity<ApiResponse<User>> getUserByUsername(@PathVariable String username) {

        User user = userService.getUserByUsername(username);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @GetMapping("/getByEmail/{email}")
    public ResponseEntity<ApiResponse<User>> getUserByEmail(@PathVariable String email) {

        User user = userService.getUserByEmail(email);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @PostMapping("/validateCredentials")
    public ResponseEntity<ApiResponse<User>> validateCredentials(@RequestBody Map<String, String> loginRequest) {

        User user = userService.validateCredentials(loginRequest);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @PutMapping("/updateUser")
    public ResponseEntity<ApiResponse<User>> updateUser(@RequestBody User user) {

        User updatedUser = userService.updateUser(user);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, updatedUser));

    }

    @DeleteMapping("/deleteById/{userId}")
    public ResponseEntity<ApiResponse<?>> deleteUserById(@PathVariable int userId) {

        userService.deleteUserByID((long) userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, null));

    }

}

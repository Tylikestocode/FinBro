package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.LoginRequest;
import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.ApiResponse;
import com.finbro.FinBroJavaSpring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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



    @PostMapping()
    public ResponseEntity<ApiResponse<User>> createUser(@RequestBody User user) {

        User savedUser = userService.createUser(user);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(new ApiResponse<>(true, savedUser));

    }

    @GetMapping("/allUsers")
    public ResponseEntity<ApiResponse<List<User>>> getUsers() {

        List<User> allUsers =  userService.getAllUsers();

        ApiResponse<List<User>> apiResponse = new ApiResponse<>(true, allUsers);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

    @GetMapping("/{userId}")
    public ResponseEntity<ApiResponse<User>> getByUserId(@PathVariable int userId) {

        User user = userService.getUserById((long) userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @GetMapping("/username/{username}")
    public ResponseEntity<ApiResponse<User>> getUserByUsername(@PathVariable String username) {

        User user = userService.getUserByUsername(username);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @GetMapping("/email/{email}")
    public ResponseEntity<ApiResponse<User>> getByEmail(@PathVariable String email) {

        User user = userService.getUserByEmail(email);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @PostMapping("/validate")
    public ResponseEntity<ApiResponse<User>> validateCredentials(@RequestBody LoginRequest loginRequest) {

        User user = userService.validateCredentials(loginRequest);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @PutMapping()
    public ResponseEntity<ApiResponse<User>> updateUser(@RequestBody User user) {

        User updatedUser = userService.updateUser(user);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, updatedUser));

    }

    @DeleteMapping("/{userId}")
    public ResponseEntity<ApiResponse<?>> deleteById(@PathVariable int userId) {

        userService.deleteUserByID((long) userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, null));

    }

}

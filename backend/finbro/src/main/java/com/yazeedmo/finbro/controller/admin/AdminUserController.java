package com.yazeedmo.finbro.controller.admin;

import com.yazeedmo.finbro.domain.ApiResponse;
import com.yazeedmo.finbro.domain.User;
import com.yazeedmo.finbro.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/users")
@CrossOrigin(origins = "http://localhost")
public class AdminUserController {

    private final UserService userService;

    @Autowired
    public AdminUserController(UserService userService) {
        this.userService = userService;
    }


    @PostMapping
    public ResponseEntity<ApiResponse<User>> createUser(@RequestBody User user) {

        User savedUser = userService.createUser(user);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(new ApiResponse<>(true, savedUser));

    }

    @GetMapping()
    public ResponseEntity<ApiResponse<List<User>>> getUsers() {

        List<User> allUsers = userService.getAllUsers();

        ApiResponse<List<User>> apiResponse = new ApiResponse<>(true, allUsers);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

    @GetMapping("/{userId}")
    public ResponseEntity<ApiResponse<User>> getByUserId(@PathVariable Long userId) {

        User user = userService.getUserById((long) userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @DeleteMapping("/{userId}")
    public ResponseEntity<ApiResponse<?>> deleteById(@PathVariable int userId) {

        userService.deleteUserByID((long) userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, null));

    }

}

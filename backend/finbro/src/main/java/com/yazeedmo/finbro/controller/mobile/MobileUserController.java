package com.yazeedmo.finbro.controller.mobile;

import com.yazeedmo.finbro.domain.LoginRequest;
import com.yazeedmo.finbro.domain.User;
import com.yazeedmo.finbro.domain.dto.UserDTO;
import com.yazeedmo.finbro.domain.ApiResponse;
import com.yazeedmo.finbro.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/mobile/users")
@CrossOrigin(origins = "http://localhost")
public class MobileUserController {

    private final UserService userService;

    @Autowired
    public MobileUserController(UserService userService) {
        this.userService = userService;
    }



    @PostMapping()
    public ResponseEntity<ApiResponse<User>> createUser(@RequestBody User user) {

        User savedUser = userService.createUser(user);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(new ApiResponse<>(true, savedUser));

    }

    @GetMapping("/{userId}")
    public ResponseEntity<ApiResponse<User>> getByUserId(@PathVariable Long userId) {

        User user = userService.getUserById((long) userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, user));

    }

    @GetMapping("/getUserWithDetails/{userId}")
    public ResponseEntity<ApiResponse<UserDTO>> getUserWithDetails(@PathVariable Long userId) {

        UserDTO userDTO = userService.getUserWithDetails(userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, userDTO));

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
    public ResponseEntity<ApiResponse<UserDTO>> validateCredentials(@RequestBody LoginRequest loginRequest) {

        User user = userService.validateCredentials(loginRequest);
        UserDTO userDTO = userService.getUserWithDetails(user.getId());

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, userDTO));

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

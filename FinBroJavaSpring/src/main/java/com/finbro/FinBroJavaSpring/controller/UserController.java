package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
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

        userService.storeUser(user);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(userService.getUserByUsername(user.getUsername()));

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

    @PutMapping("/updateUser")
    public ResponseEntity<?> updateUser(@RequestBody User user) {

        userService.updateUser(user);
        return ResponseEntity
                .status(HttpStatus.ACCEPTED)
                .body(user);

    }

    @DeleteMapping("/deleteByUserId/{userId}")
    public ResponseEntity<?> deleteUserById(@PathVariable int userId) {

        userService.deleteUserByID(userId);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body("User successfully deleted");

    }

}

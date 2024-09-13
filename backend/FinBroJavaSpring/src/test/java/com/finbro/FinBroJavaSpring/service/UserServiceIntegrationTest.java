package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.LoginRequest;
import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.InvalidDataFormatException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.ResourceAlreadyExistsException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.ResourceNotFoundException;
import com.finbro.FinBroJavaSpring.exception.userexceptions.*;
import com.finbro.FinBroJavaSpring.repository.UserRepository;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
@ActiveProfiles("test")
public class UserServiceIntegrationTest {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    private User user1;
    private User user2;
    private User user3;
    private User user4;
    private User user5;

    @BeforeEach
    public void setUp() {

        userRepository.deleteAll();

        user1 = new User();
        user1.setName("John");
        user1.setSurname("Doe");
        user1.setAge(30);
        user1.setUsername("john.d");
        user1.setEmail("john.d@example.com");
        user1.setPassword("password1");

        user2 = new User();
        user2.setName("Alice");
        user2.setSurname("Johnson");
        user2.setAge(28);
        user2.setUsername("alice.j");
        user2.setEmail("alice.j@example.com");
        user2.setPassword("password2");

        user3 = new User();
        user3.setName("Bob");
        user3.setSurname("Smith");
        user3.setAge(35);
        user3.setUsername("bob.s");
        user3.setEmail("bob.s@example.com");
        user3.setPassword("password3");

        user4 = new User();
        user4.setName("Emily");
        user4.setSurname("Brown");
        user4.setAge(24);
        user4.setUsername("emily.b");
        user4.setEmail("emily.b@example.com");
        user4.setPassword("password4");

        user5 = new User();
        user5.setName("Charlie");
        user5.setSurname("Davis");
        user5.setAge(29);
        user5.setUsername("charlie.d");
        user5.setEmail("charlie.d@example.com");
        user5.setPassword("password5");

    }

    @Test
    public void UserService_SaveUser_ReturnsUserSaved() {

        userService.createUser(user4);
        User user = userService.getUserByUsername(user4.getUsername());

        Assertions.assertThat(user.getEmail()).isEqualTo("emily.b@example.com");

    }

    @Test
    public void UserService_SaveUser_ReturnsUserAlreadyExistsException() {

        userService.createUser(user1);
        User user = new User((long) 1, "newUser", "NewSurname", 23, "john.d", "newEmail@john.com", "newPass");

        assertThrows(ResourceAlreadyExistsException.class, () -> userService.createUser(user));

    }

    @Test
    public void UserService_SaveUser_ReturnsInvalidEmailFormatException() {

        user1.setEmail("john");
        user2.setEmail("");
        user3.setEmail("new@");
        user4.setEmail("email$example");

        assertThrows(InvalidDataFormatException.class, () -> userService.createUser(user1));
        assertThrows(InvalidDataFormatException.class, () -> userService.createUser(user2));
        assertThrows(InvalidDataFormatException.class, () -> userService.createUser(user3));
        assertThrows(InvalidDataFormatException.class, () -> userService.createUser(user4));

    }

    @Test
    public void UserService_SaveUser_ReturnsEmailAlreadyExistsException() {

        userService.createUser(user1);
        User user = new User((long) 1, "newUser", "NewSurname", 23, "newUsername", "john.d@example.com", "newPass");

        assertThrows(ResourceAlreadyExistsException.class, () -> userService.createUser(user));

    }

    @Test
    public void UserService_FindAllUsers_ReturnsEmptyList() {

        List<User> allUsers = userService.getAllUsers();

        assertThat(allUsers).isNotNull();
        assertThat(allUsers.size()).isEqualTo(0);

    }

    @Test
    public void UserService_FindAllUsers_ReturnsAllUsers() {

        userService.createUser(user1);
        userService.createUser(user2);
        userService.createUser(user3);
        userService.createUser(user4);
        userService.createUser(user5);

        List<User> allUsers = userService.getAllUsers();

        assertThat(allUsers).isNotNull();
        assertThat(allUsers.size()).isEqualTo(5);

    }

    @Test
    public void UserService_GetUserByID_ReturnsUser() {

        userService.createUser(user1);


        long id = userService.getUserByUsername("john.d").getId(); // 5 Users were already added in data.sql
        User user = userService.getUserById(id);

        assertThat(user).isNotNull();
        assertThat(user.getName()).isEqualTo("John");

    }

    @Test
    public void UserService_GetUserByID_ReturnsUserIDNotFoundException() {

        userService.createUser(user1);

        long id = 12;

        assertThrows(ResourceNotFoundException.class, () -> userService.getUserById(id));

    }

    @Test
    public void UserService_GetUserByUsername_ReturnsUser() {

        userService.createUser(user1);

        User user = userService.getUserByUsername("john.d");

        assertThat(user).isNotNull();
        assertThat(user.getName()).isEqualTo("John");

    }

    @Test
    public void UserService_GetUserByUsername_ReturnsUsernameNotFoundException() {

        userService.createUser(user1);

        assertThrows(ResourceNotFoundException.class, () -> userService.getUserByUsername("tester"));

    }

    @Test
    public void UserService_GetUserByEmail_ReturnsUser() {

        userService.createUser(user1);

        User user = userService.getUserByEmail("john.d@example.com");

        assertThat(user).isNotNull();
        assertThat(user.getName()).isEqualTo("John");

    }

    @Test
    public void UserService_GetUserByEmail_ReturnsEmailNotFoundException() {

        userService.createUser(user1);

        assertThrows(ResourceNotFoundException.class, () -> userService.getUserByEmail("finbro@gmail.com"));

    }

    @Test
    public void UserService_ValidateCredentials_ReturnsUser() {

        userService.createUser(user1);

        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setEmail("john.d@example.com");
        loginRequest.setPassword("password1");

        User user = userService.validateCredentials(loginRequest);

        assertThat(user).isNotNull();
        assertThat(user.getName()).isEqualTo("John");

    }

    @Test
    public void UserService_ValidateCredentials_ReturnsInvalidLoginException() {

        userService.createUser(user1);

        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setEmail("john.d@example.com");
        loginRequest.setPassword("wrongPassword");

        assertThrows(IncorrectPasswordException.class, () -> userService.validateCredentials(loginRequest));

    }

    @Test
    public void UserService_UpdateUser_ReturnsUpdatedUser() {

        userService.createUser(user1);

        User user = userService.getUserByUsername("john.d");

        user.setName("NewName");
        user.setSurname("newSurname");
        user.setAge(4);
        user.setUsername("NewUsername");
        user.setEmail("NewEmail@example.com");
        user.setPassword("NewPassword");

        userService.updateUser(user);

        User updatedUser = userService.getUserByUsername("NewUsername");

        assertThat(updatedUser).isNotNull();
        assertThat(updatedUser.getName()).isEqualTo("NewName");
        assertThat(updatedUser.getEmail()).isEqualTo("NewEmail@example.com");
        assertThat(updatedUser.getPassword()).isEqualTo("NewPassword");

    }

    @Test
    public void UserService_UpdateUser_ReturnsUserIdNotFoundException() {

        userService.createUser(user1);

        User user = userService.getUserByUsername("john.d");
        user.setId((long) 45);
        user.setName("NewName");
        user.setSurname("newSurname");
        user.setAge(4);
        user.setUsername("NewUsername");
        user.setEmail("NewEmail@example.com");
        user.setPassword("NewPassword");

        assertThrows(ResourceNotFoundException.class, () -> userService.updateUser(user));

    }

    @Test
    public void UserService_UpdateUser_UserAlreadyExistsException() {

        userService.createUser(user1);
        userService.createUser(user2);
        userService.createUser(user3);

        User user = userService.getUserByUsername("john.d");

        user.setUsername("alice.j");
        assertThrows(ResourceAlreadyExistsException.class, () -> userService.updateUser(user));

        user.setUsername("bob.s");
        assertThrows(ResourceAlreadyExistsException.class, () -> userService.updateUser(user));

    }

    @Test
    public void UserService_UpdateUser_ReturnsEmailAlreadyExistsException() {

        userService.createUser(user1);
        userService.createUser(user2);
        userService.createUser(user3);

        User user = userService.getUserByUsername("john.d");

        user.setEmail("alice.j@example.com");
        assertThrows(ResourceAlreadyExistsException.class, () -> userService.updateUser(user));

        user.setEmail("bob.s@example.com");
        assertThrows(ResourceAlreadyExistsException.class, () -> userService.updateUser(user));

    }

    @Test
    public void UserService_UpdateUser_DeletesUser() {

        userService.createUser(user1);
        userService.createUser(user2);
        userService.createUser(user3);

        long id = userService.getUserByUsername("alice.j").getId();
        userService.deleteUserByID(id);      // Deleting user2

        assertThrows(ResourceNotFoundException.class, () -> userService.deleteUserByID((long) 6));

    }

}

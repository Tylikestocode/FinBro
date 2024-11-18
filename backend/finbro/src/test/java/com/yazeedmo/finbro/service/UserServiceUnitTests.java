package com.yazeedmo.finbro.service;


import com.yazeedmo.finbro.domain.LoginRequest;
import com.yazeedmo.finbro.domain.User;
import com.yazeedmo.finbro.exception.general.InvalidDataFormatException;
import com.yazeedmo.finbro.exception.general.ResourceAlreadyExistsException;
import com.yazeedmo.finbro.exception.general.ResourceNotFoundException;
import com.yazeedmo.finbro.exception.user.IncorrectPasswordException;
import com.yazeedmo.finbro.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class UserServiceUnitTests {

    @Mock
    private UserRepository userRepository;

    @Mock
    private GmailService gmailService;

    @InjectMocks
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
        user1.setPassword("hashed_password4");

        user2 = new User();
        user2.setName("Alice");
        user2.setSurname("Johnson");
        user2.setAge(28);
        user2.setUsername("alice.j");
        user2.setEmail("alice.j@example.com");
        user2.setPassword("hashed_password1");

        user3 = new User();
        user3.setName("Bob");
        user3.setSurname("Smith");
        user3.setAge(35);
        user3.setUsername("bob.s");
        user3.setEmail("bob.s@example.com");
        user3.setPassword("hashed_password2");

        user4 = new User();
        user4.setName("Emily");
        user4.setSurname("Brown");
        user4.setAge(24);
        user4.setUsername("emily.b");
        user4.setEmail("emily.b@example.com");
        user4.setPassword("hashed_password3");

        user5 = new User();
        user5.setName("Charlie");
        user5.setSurname("Davis");
        user5.setAge(29);
        user5.setUsername("charlie.d");
        user5.setEmail("charlie.d@example.com");
        user5.setPassword("hashed_password5");

    }


    @Test
    public void UserService_SaveUser_SavedUser() throws Exception {

        when(userRepository.save(user1)).thenReturn(user1);

        User savedUser = userService.createUser(user1);

        verify(userRepository).save(user1);
        verify(gmailService).sendWelcomeEmail(user1.getEmail());

        assertThat(savedUser).isNotNull();

    }

    @Test
    public void UserService_SaveUser_UserAlreadyExistsException() {

        String username = user1.getUsername();
        when(userRepository.existsByUsername(username)).thenReturn(true);

        assertThrows(ResourceAlreadyExistsException.class, () -> userService.createUser(user1));

    }

    @Test
    public void UserService_SaveUser_EmailAlreadyExistsException() {

        String email = user1.getEmail();
        when(userRepository.existsByEmail(email)).thenReturn(true);

        assertThrows(ResourceAlreadyExistsException.class, () -> userService.createUser(user1));

    }

    @Test
    public void UserService_SaveUser_InvalidEmailFormatException() {

        user1.setEmail("john.d#example.com");
        user2.setEmail("");
        user3.setEmail("emily.b.com");

        assertThrows(InvalidDataFormatException.class, () -> userService.createUser(user1));
        assertThrows(InvalidDataFormatException.class, () -> userService.createUser(user2));
        assertThrows(InvalidDataFormatException.class, () -> userService.createUser(user3));

    }


    @Test
    public void UserService_FindAllUsers_AllUsers() {

        when(userRepository.findAll()).thenReturn(List.of(user1, user2, user3, user4, user5));

        List<User> allUsers = userService.getAllUsers();

        assertThat(allUsers).isNotNull();
        assertThat(allUsers.size()).isEqualTo(5);

    }


    @Test
    public void UserService_GetUserById_UserById() {

        when(userRepository.existsById(user1.getId())).thenReturn(true);
        when(userRepository.findById(user1.getId())).thenReturn(Optional.ofNullable(user1));

        User user = userService.getUserById(user1.getId());

        assertThat(user.getName()).isEqualTo(user1.getName());

    }

    @Test
    public void UserService_GetUserById_ResourceNotFoundException() {

        when(userRepository.existsById(user1.getId())).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> userService.getUserById(user1.getId()));

    }

    @Test
    public void UserService_GetUserByUsername_UserByUsername() {

        when(userRepository.existsByUsername(user1.getUsername())).thenReturn(true);
        when(userRepository.findByUsername(user1.getUsername())).thenReturn(user1);

        User user = userService.getUserByUsername(user1.getUsername());

        assertThat(user.getName()).isEqualTo(user1.getName());

    }

    @Test
    public void UserService_GetUserByUsername_ResourceNotFoundException() {

        when(userRepository.existsByUsername(user1.getUsername())).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> userService.getUserByUsername(user1.getUsername()));

    }

    @Test
    public void UserService_GetUserByEmail_UserByEmail() {

        when(userRepository.existsByEmail(user1.getEmail())).thenReturn(true);
        when(userRepository.findByEmail(user1.getEmail())).thenReturn(user1);

        User user = userService.getUserByEmail(user1.getEmail());

        assertThat(user.getName()).isEqualTo(user1.getName());

    }

    @Test
    public void UserService_getUserByEmail_ResourceNotFoundException() {

        when(userRepository.existsByEmail(user1.getEmail())).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> userService.getUserByEmail(user1.getEmail()));

    }

    @Test
    public void UserService_ValidateCredentials_ValidUser() {

        when(userRepository.existsByEmail(user1.getEmail())).thenReturn(true);
        when(userRepository.findByEmail(user1.getEmail())).thenReturn(user1);

        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setEmail(user1.getEmail());
        loginRequest.setPassword(user1.getPassword());

        User user = userService.validateCredentials(loginRequest);

        assertThat(user.getUsername()).isEqualTo(user1.getUsername());

    }

    @Test
    public void UserService_ValidateCredentials_ResourceNotFoundException() {

        when(userRepository.existsByEmail(user1.getEmail())).thenReturn(false);

        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setEmail(user1.getEmail());
        loginRequest.setPassword(user1.getPassword());

        assertThrows(ResourceNotFoundException.class, () -> userService.validateCredentials(loginRequest));

    }

    @Test
    public void UserService_ValidateCredentials_IncorrectPasswordException() {

        when(userRepository.existsByEmail(user1.getEmail())).thenReturn(true);
        when(userRepository.findByEmail(user1.getEmail())).thenReturn(user1);

        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setEmail(user1.getEmail());
        loginRequest.setPassword("Incorrect Password");

        assertThrows(IncorrectPasswordException.class, () -> userService.validateCredentials(loginRequest));

    }

    @Test
    public void UserService_UpdateUser_UpdatedUser() {

        when(userRepository.existsById(user1.getId())).thenReturn(true);
        when(userRepository.findById(user1.getId())).thenReturn(Optional.ofNullable(user1));
        when(userRepository.save(user1)).thenReturn(user1);

        user1.setUsername("newUsername");
        user1.setPassword("newPassword");
        user1.setEmail("newEmail");

        User user = userService.updateUser(user1);

        assertThat(user.getUsername()).isEqualTo(user1.getUsername());
        assertThat(user.getEmail()).isEqualTo(user1.getEmail());
        assertThat(user.getPassword()).isEqualTo(user1.getPassword());

    }

    @Test
    public void UserService_UpdateUser_ResourceNotFoundException() {

        when(userRepository.existsById(user1.getId())).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,() -> userService.updateUser(user1));

    }

}

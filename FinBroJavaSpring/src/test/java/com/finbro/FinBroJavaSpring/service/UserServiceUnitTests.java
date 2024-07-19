package com.finbro.FinBroJavaSpring.service;


import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.EmailAlreadyExistsException;
import com.finbro.FinBroJavaSpring.exception.InvalidEmailFormatException;
import com.finbro.FinBroJavaSpring.exception.UserAlreadyExistsException;
import com.finbro.FinBroJavaSpring.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class UserServiceUnitTests {

    @Mock
    private UserRepository userRepository;

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
    public void UserService_StoreUser_UserSuccessfullySaved() {

        // Act
        when(userRepository.save(user1)).thenReturn(user1);
        userService.saveUser(user1);

        // Assert
        verify(userRepository).save(user1);

    }

    @Test
    public void UserService_StoreUser_ReturnUserAlreadyExistsException() {

        // Act
        when(userRepository.existsByUsername(user1.getUsername())).thenReturn(true);

        // Assert
        assertThrows(UserAlreadyExistsException.class, () -> userService.saveUser(user1));

    }

    @Test
    public void UserService_StoreUser_ReturnsEmailAlreadyExistsException() {

        // Act
        when(userRepository.existsByEmail(user1.getEmail())).thenReturn(true);

        // Assert
        assertThrows(EmailAlreadyExistsException.class, () -> userService.saveUser(user1));

    }

    @Test
    public void UserService_StoreUser_ReturnsInvalidEmailFormatException() {

        // Arrange
        user1.setEmail("john.d#example.com");
        user2.setEmail("");
        user3.setEmail("emily.b.com");

        // Assert
        assertThrows(InvalidEmailFormatException.class, () -> userService.saveUser(user1));
        assertThrows(InvalidEmailFormatException.class, () -> userService.saveUser(user2));
        assertThrows(InvalidEmailFormatException.class, () -> userService.saveUser(user3));

    }

    @Test
    public void UserService_FindAllUsers_ReturnsAllUsers() {

        when(userRepository.findAll()).thenReturn(List.of(user1, user2, user3, user4, user5));

        List<User> allUsers = userService.findAllUsers();

        assertThat(allUsers).isNotNull();
        assertThat(allUsers.size()).isEqualTo(5);

    }

}

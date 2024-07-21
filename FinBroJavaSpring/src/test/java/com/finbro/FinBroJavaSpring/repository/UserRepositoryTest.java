package com.finbro.FinBroJavaSpring.repository;

import com.finbro.FinBroJavaSpring.domain.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@ActiveProfiles("test")
public class UserRepositoryTest {

    @Autowired
    private UserRepository userRepository;

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
    public void UserRepository_Save_ReturnSavedUser() {

        // Arrange (done in @BeforeEach)

        //Act
        User savedUser = userRepository.save(user2);

        // Assert
        assertThat(savedUser).isNotNull();
        assertThat(savedUser.getName()).isEqualTo("Alice");

    }

    @Test
    public void UserRepository_FindAll_ReturnsAll() {

        // Arrange
        userRepository.saveAll(List.of(user1, user2, user3, user4, user5));

        // Act
        List<User> allUsers = (List<User>) userRepository.findAll();

        // Assert
        assertThat(allUsers.size()).isEqualTo(5);

    }

    @Test
    public void UserRepository_FindById_ReturnsUserByID() {

        // Arrange
        userRepository.save(user1);

        // Act
        User user = userRepository.findByUsername("john.d");
        long userId = user.getId();
        User returnedUser = userRepository.findById(userId).orElse(null);

        // Assert
        assertThat(returnedUser).isNotNull();
        assertThat(returnedUser.getName()).isEqualTo("John");

    }

    @Test
    public void UserRepository_FindByUsername_ReturnsUserByUsername() {

        // Arrange
        userRepository.save(user1);

        //Act
        User user = userRepository.findByUsername("john.d");

        // Assert
        assertThat(user.getName()).isEqualTo("John");

    }

    @Test
    public void UserRepository_FindByEmail_ReturnsUserByEmail() {

        // Arrange
        userRepository.save(user1);

        // Act
        User user = userRepository.findByEmail("john.d@example.com");

        // Assert
        assertThat(user).isNotNull();
        assertThat(user.getUsername()).isEqualTo("john.d");

    }

    @Test
    public void UserRepository_Save_ReturnUpdatedUser() {

        // Arrange
        userRepository.save(user1);

        // Act
        user1.setName("NewUser");
        user1.setPassword("NewPassword");
        User user = userRepository.save(user1);

        // Assert
        assertThat(user).isNotNull();
        assertThat(user.getName()).isEqualTo("NewUser");
        assertThat(user.getPassword()).isEqualTo("NewPassword");

    }

    @Test
    public void UserRepository_Delete_DeletedUserNotFoundByUsername() {

        // Arrange
        userRepository.saveAll(List.of(user1, user2, user3, user4, user5));

        // Act
        userRepository.delete(user2);
        User user = userRepository.findByUsername(user2.getUsername());

        // Assert
        assertThat(user).isNull();

    }

}

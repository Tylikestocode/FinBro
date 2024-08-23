package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.service.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
public class UserControllerUnitTests {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    private static ObjectMapper mapper = new ObjectMapper();

    private User user1;
    private User user2;

    @BeforeEach
    public void setUp() {

        user1 = new User();
        user1.setId((long) 1);
        user1.setUsername("testUser1");
        user1.setEmail("test1@example.com");
        user1.setPassword("password1");

        user2 = new User();
        user2.setId((long) 2);
        user2.setUsername("testUser2");
        user2.setEmail("test2@example.com");
        user2.setPassword("password2");

    }

    @Test
    public void testCreateUser() throws Exception {

        Mockito.when(userService.createUser(Mockito.any(User.class))).thenReturn(user1);

        String json = mapper.writeValueAsString(user1);

        mockMvc.perform(post("/api/users/addUser")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.id").value(1))
                .andExpect(jsonPath("$.data.username").value("testUser1"));
    }

    @Test
    public void testGetUsers() throws Exception {

        Mockito.when(userService.getAllUsers()).thenReturn(Arrays.asList(user1, user2));

        mockMvc.perform(get("/api/users/allUsers"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data[0].id").value(1))
                .andExpect(jsonPath("$.data[0].username").value("testUser1"))
                .andExpect(jsonPath("$.data[0].email").value("test1@example.com"))
                .andExpect(jsonPath("$.data[1].id").value(2))
                .andExpect(jsonPath("$.data[1].username").value("testUser2"))
                .andExpect(jsonPath("$.data[1].email").value("test2@example.com"));
    }

    @Test
    public void testGetByUserId() throws Exception {

        Mockito.when(userService.getUserById((long) 1)).thenReturn(user1);

        mockMvc.perform(get("/api/users/getByUserId/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.id").value(1))
                .andExpect(jsonPath("$.data.username").value("testUser1"))
                .andExpect(jsonPath("$.data.email").value("test1@example.com"));
    }

    @Test
    public void testGetUserByUsername() throws Exception {

        Mockito.when(userService.getUserByUsername("testUser1")).thenReturn(user1);

        mockMvc.perform(get("/api/users/getByUsername/testUser1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.id").value(1))
                .andExpect(jsonPath("$.data.username").value("testUser1"))
                .andExpect(jsonPath("$.data.email").value("test1@example.com"));
    }

    @Test
    public void testGetByEmail() throws Exception {

        Mockito.when(userService.getUserByEmail("test1@example.com")).thenReturn(user1);

        mockMvc.perform(get("/api/users/getByEmail/test1@example.com"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.id").value(1))
                .andExpect(jsonPath("$.data.username").value("testUser1"))
                .andExpect(jsonPath("$.data.email").value("test1@example.com"));
    }

    @Test
    public void testValidateCredentials() throws Exception {

        Map<String, String> loginRequest = new HashMap<>();
        loginRequest.put("email", "test1@example.com");
        loginRequest.put("password", "password1");

        Mockito.when(userService.validateCredentials(loginRequest)).thenReturn(user1);

        String json = mapper.writeValueAsString(loginRequest);

        mockMvc.perform(post("/api/users/validateCredentials")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.data.id").value(1))
                .andExpect(jsonPath("$.data.email").value("test1@example.com"))
                .andExpect(jsonPath("$.data.password").value("password1"));
    }

    @Test
    public void testUpdateUser() throws Exception {

        Mockito.when(userService.updateUser(Mockito.any(User.class))).thenReturn(user1);

        String json = mapper.writeValueAsString(user1);

        mockMvc.perform(put("/api/users/updateUser")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.id").value(1))
                .andExpect(jsonPath("$.data.username").value("testUser1"))
                .andExpect(jsonPath("$.data.email").value("test1@example.com"));
    }

    @Test
    public void testDeleteById() throws Exception {
        Mockito.doNothing().when(userService).deleteUserByID((long) 1);

        mockMvc.perform(delete("/api/users/deleteById/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}

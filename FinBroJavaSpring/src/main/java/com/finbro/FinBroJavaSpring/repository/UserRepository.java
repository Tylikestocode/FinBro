package com.finbro.FinBroJavaSpring.repository;

import com.finbro.FinBroJavaSpring.domain.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRepository {

    private final JdbcTemplate jdbc;

    public UserRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }



    // Create and store new User
    public void storeUser(User user) {

        String sql =
                "INSERT INTO Users(Name, Surname, Age, Username, Email, Password)" +
                " VALUES (?, ?, ?, ?, ?, ?)";
        jdbc.update(sql, user.getName(), user.getSurname(), user.getAge(), user.getUsername(), user.getEmail(), user.getPassword());

    }

    // Return all Users
    public List<User> findAllUsers() {

        String sql = "SELECT * FROM Users";

        RowMapper<User> userRowMapper = (r, i) -> {

            User rowObject = new User();
            rowObject.setId(r.getInt("UserID"));
            rowObject.setName(r.getString("Name"));
            rowObject.setSurname(r.getString("Surname"));
            rowObject.setAge(r.getInt("Age"));
            rowObject.setUsername(r.getString("Username"));
            rowObject.setEmail(r.getString("Email"));
            rowObject.setPassword(r.getString("Password"));
            return rowObject;

        };

        return jdbc.query(sql, userRowMapper);

    }

    // Get User by ID
    public User getUserByID(int id) {

        String sql = "SELECT * FROM Users WHERE UserID = ?";

        RowMapper<User> userRowMapper = (r, i) -> {

            User rowObject = new User();
            rowObject.setId(r.getInt("UserID"));
            rowObject.setName(r.getString("Name"));
            rowObject.setSurname(r.getString("Surname"));
            rowObject.setAge(r.getInt("Age"));
            rowObject.setUsername(r.getString("Username"));
            rowObject.setEmail(r.getString("Email"));
            rowObject.setPassword(r.getString("Password"));
            return rowObject;

        };

        return jdbc.queryForObject(sql, userRowMapper, id);

    }

    // Get User by Username
    public User getUserByUsername(String username) {

        String sql = "SELECT * FROM Users WHERE Username = ?";

        RowMapper<User> userRowMapper = (r, i) -> {

            User rowObject = new User();
            rowObject.setId(r.getInt("UserID"));
            rowObject.setName(r.getString("Name"));
            rowObject.setSurname(r.getString("Surname"));
            rowObject.setAge(r.getInt("Age"));
            rowObject.setUsername(r.getString("Username"));
            rowObject.setEmail(r.getString("Email"));
            rowObject.setPassword(r.getString("Password"));
            return rowObject;

        };

        return jdbc.queryForObject(sql, userRowMapper, username);

    }

    // Get User by Email
    public User getUserByEmail(String email) {

        String sql = "SELECT * FROM Users WHERE Email = ?";

        RowMapper<User> userRowMapper = (r, i) -> {

            User rowObject = new User();
            rowObject.setId(r.getInt("UserID"));
            rowObject.setName(r.getString("Name"));
            rowObject.setSurname(r.getString("Surname"));
            rowObject.setAge(r.getInt("Age"));
            rowObject.setUsername(r.getString("Username"));
            rowObject.setEmail(r.getString("Email"));
            rowObject.setPassword(r.getString("Password"));
            return rowObject;

        };

        return jdbc.queryForObject(sql, userRowMapper, email);

    }

    // Check if a username exists
    public boolean usernameExists(String username) {

        String sql = "SELECT COUNT(*) FROM Users WHERE Username = ?";
        Integer count =  jdbc.queryForObject(sql, Integer.class, username);
        return count != null && count > 0;

    }

    // Check if a UserID exists
    public boolean userIDExists(int userID) {

        String sql = "SELECT COUNT(*) FROM Users WHERE UserID = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, userID);
        return count != null && count > 0;

    }

    // Check if the email already exists
    public boolean emailExists(String email) {

        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        Integer count = jdbc.queryForObject(sql, Integer.class, email);
        return count != null && count > 0;

    }

    // Update an existing User
    public void updateUser(User user) {

        String sql =
                "UPDATE Users SET " +
                "Name = ?," +
                "Surname = ?," +
                "Age = ?," +
                "Username = ?," +
                "Email = ?," +
                "Password = ? " +
                "WHERE UserID = ?";

        jdbc.update(sql,
                user.getName(),
                user.getSurname(),
                user.getAge(),
                user.getUsername(),
                user.getEmail(),
                user.getPassword(),
                user.getId());
    }

    // Delete User by UserID
    public void deleteUserByID(int userID) {

        String sql = "DELETE FROM Users WHERE UserID = ?";
        jdbc.update(sql, userID);

    }

}

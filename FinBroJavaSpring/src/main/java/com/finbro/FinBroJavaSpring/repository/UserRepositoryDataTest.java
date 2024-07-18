package com.finbro.FinBroJavaSpring.repository;

import com.finbro.FinBroJavaSpring.domain.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserRepositoryDataTest extends CrudRepository<User, Integer> {

    @Query("SELECT * FROM Users")
    List<User> findAllUsers();

}

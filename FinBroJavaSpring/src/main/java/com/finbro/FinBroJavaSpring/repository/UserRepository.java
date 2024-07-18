package com.finbro.FinBroJavaSpring.repository;

import com.finbro.FinBroJavaSpring.domain.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Integer> {

    @Query("SELECT COUNT(*) FROM Users WHERE Username = :username")
    boolean existsByUsername(String username);

    @Query("SELECT * FROM Users WHERE Username = :username")
    User findByUsername(String username);

    @Query("SELECT COUNT(*) FROM Users WHERE Email = :email")
    boolean existsByEmail(String email);

    @Query("SELECT * FROM Users WHERE Email = :email")
    User findByEmail(String email);

}

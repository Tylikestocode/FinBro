package com.finbro.FinBroJavaSpring.repository;

import com.finbro.FinBroJavaSpring.domain.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

    @Query("SELECT COUNT(*) FROM USERS WHERE Username = :username;")
    boolean existsByUsername(String username);

    @Query("SELECT * FROM USERS WHERE Username = :username;")
    User findByUsername(String username);

    @Query("SELECT COUNT(*) FROM USERS WHERE Email = :email;")
    boolean existsByEmail(String email);

    @Query("SELECT * FROM USERS WHERE Email = :email;")
    User findByEmail(String email);

}

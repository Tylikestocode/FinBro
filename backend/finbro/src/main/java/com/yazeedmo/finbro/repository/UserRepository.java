package com.yazeedmo.finbro.repository;

import com.yazeedmo.finbro.domain.User;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

    @Query("SELECT COUNT(*) FROM USERS WHERE username = :username;")
    boolean existsByUsername(String username);

    @Query("SELECT * FROM USERS WHERE username = :username;")
    User findByUsername(String username);

    @Query("SELECT COUNT(*) FROM USERS WHERE email = :email;")
    boolean existsByEmail(String email);

    @Query("SELECT * FROM USERS WHERE email = :email;")
    User findByEmail(String email);

    @Query("SELECT COUNT(*) FROM USERS")
    long countTotalUsers();

}

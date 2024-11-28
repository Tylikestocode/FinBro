package com.yazeedmo.finbro.repository;

import com.yazeedmo.finbro.domain.Account;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AccountRepository extends CrudRepository<Account, Long> {

    @Query("SELECT * FROM ACCOUNTS WHERE user_id = :user_id")
    List<Account> findAllByUserId(@Param("user_id") Long userId);

    @Query("SELECT COUNT(*) FROM ACCOUNTS")
    long countTotalAccounts();

    @Query(value = "SELECT * FROM ACCOUNTS WHERE user_id = :userId AND name = :name")
    Optional<Account> findByUserIdAndName(@Param("userId") Long userId, @Param("name") String name);

    @Query("SELECT COUNT(*) FROM ACCOUNTS WHERE user_id = :userId AND name = :name")
    int countByUserIdAndName(@Param("userId") Long userId, @Param("name") String name);

}

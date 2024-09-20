package com.yazeedmo.finbro.repository;

import com.yazeedmo.finbro.domain.Account;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AccountRepository extends CrudRepository<Account, Long> {

    @Query("SELECT * FROM ACCOUNTS WHERE user_id = :user_id")
    List<Account> findAllByUserId(@Param("user_id") Long userId);

}

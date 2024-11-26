package com.yazeedmo.finbro.repository;

import com.yazeedmo.finbro.domain.Transaction;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransactionRepository extends CrudRepository<Transaction, Long> {

    @Query("SELECT * FROM TRANSACTIONS WHERE user_id = :user_id")
    List<Transaction> findAllByUserId(@Param("user_id") Long userId);

    @Query("SELECT * FROM TRANSACTIONS WHERE account_id = :account_id")
    List<Transaction> findAllByAccountId(@Param("account_id") Long accountId);

    @Query("SELECT COUNT(*) FROM TRANSACTIONS")
    long countTotalTransactions();

}

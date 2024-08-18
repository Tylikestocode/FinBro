package com.finbro.FinBroJavaSpring.repository;

import com.finbro.FinBroJavaSpring.domain.Transaction;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransactionRepository extends CrudRepository<Transaction, Long> {

    @Query("SELECT * FROM TRANSACTIONS WHERE user_id = :user_id")
    List<Transaction> findAllTransactionsByUserId(Long userId);

    @Query("SELECT * FROM TRANSACTIONS WHERE account_id = :account_id")
    List<Transaction> findAllTransactionsByAccountId(Long accountId);

}

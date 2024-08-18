package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.Transaction;
import com.finbro.FinBroJavaSpring.exception.ApiResponse;
import com.finbro.FinBroJavaSpring.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/transactions")
@CrossOrigin(origins = "http://localhost")
public class TransactionController {

    private final TransactionService transactionService;

    @Autowired
    public TransactionController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    @PostMapping("/addTransaction")
    public ResponseEntity<ApiResponse<Transaction>> addTransaction(@RequestBody Transaction transaction) {

        Transaction savedTransaction = transactionService.saveTransaction(transaction);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, savedTransaction));

    }

    @GetMapping("/allTransactions")
    public ResponseEntity<ApiResponse<List<Transaction>>> getTransactions() {

        List<Transaction> allTransactions = transactionService.findAllTransactions();

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, allTransactions));

    }

    @GetMapping("/findById/{id}")
    public ResponseEntity<ApiResponse<Transaction>> getTransactionById(@PathVariable Long id) {

        Transaction transaction = transactionService.findByTransactionId(id);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, transaction));

    }

    @GetMapping("/findAllByUserId/{id}")
    public ResponseEntity<ApiResponse<List<Transaction>>> findAllByUserId(@PathVariable Long id) {

        List<Transaction> userTransactions = transactionService.findAllByUserId(id);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, userTransactions));

    }

    @GetMapping("/findAllByAccountId/{id}")
    public ResponseEntity<ApiResponse<List<Transaction>>> findAllByAccountId(@PathVariable Long id) {

        List<Transaction> accountTransactions = transactionService.findAllByAccountId(id);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, accountTransactions));

    }

    @PutMapping("/updateAccount")
    public ResponseEntity<ApiResponse<Transaction>> updateTransaction(@RequestBody Transaction transaction) {

        Transaction updatedTransaction = transactionService.updateTransaction(transaction);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, updatedTransaction));

    }

    @DeleteMapping("/deleteById/{id}")
    public ResponseEntity<ApiResponse<?>> deleteTransaction(@PathVariable Long transactionId) {

        transactionService.deleteByTransactionId(transactionId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, null));

    }

}

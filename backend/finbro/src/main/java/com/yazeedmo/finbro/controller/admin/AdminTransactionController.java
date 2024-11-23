package com.yazeedmo.finbro.controller.admin;

import com.yazeedmo.finbro.domain.ApiResponse;
import com.yazeedmo.finbro.domain.Transaction;
import com.yazeedmo.finbro.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admin/transactions")
@CrossOrigin(origins = "http://localhost")
public class AdminTransactionController {

    private final TransactionService transactionService;

    @Autowired
    public AdminTransactionController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }



    @GetMapping()
    public ResponseEntity<ApiResponse<List<Transaction>>> getTransactions() {

        List<Transaction> allTransactions = transactionService.getAllTransactions();

        ApiResponse<List<Transaction>> apiResponse = new ApiResponse<>(true, allTransactions);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

}

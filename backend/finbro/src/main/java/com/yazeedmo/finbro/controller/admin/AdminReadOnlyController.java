package com.yazeedmo.finbro.controller.admin;

import com.yazeedmo.finbro.domain.*;
import com.yazeedmo.finbro.exception.ApiResponse;
import com.yazeedmo.finbro.service.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
@CrossOrigin(origins = "http://localhost")
public class AdminReadOnlyController {

    private final UserService userService;
    private final AccountService accountService;
    private final TransactionService transactionService;
    private final CategoryService categoryService;
    private final RegularPaymentService regularPaymentService;

    public AdminReadOnlyController(
            UserService userService,
            AccountService accountService,
            TransactionService transactionService,
            CategoryService categoryService,
            RegularPaymentService regularPaymentService)
    {
        this.userService = userService;
        this.accountService = accountService;
        this.transactionService = transactionService;
        this.categoryService = categoryService;
        this.regularPaymentService = regularPaymentService;
    }

    @GetMapping("/users")
    public ResponseEntity<ApiResponse<List<User>>> getUsers() {

        List<User> allUsers = userService.getAllUsers();

        ApiResponse<List<User>> apiResponse = new ApiResponse<>(true, allUsers);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

    @GetMapping("/accounts")
    public ResponseEntity<ApiResponse<List<Account>>> getAccounts() {

        List<Account> allAccounts = accountService.getAllAccounts();

        ApiResponse<List<Account>> apiResponse = new ApiResponse<>(true, allAccounts);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

    @GetMapping("/transactions")
    public ResponseEntity<ApiResponse<List<Transaction>>> getTransactions() {

        List<Transaction> allTransactions = transactionService.getAllTransactions();

        ApiResponse<List<Transaction>> apiResponse = new ApiResponse<>(true, allTransactions);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

    @GetMapping("/categories")
    public ResponseEntity<ApiResponse<List<Category>>> getCategories() {

        List<Category> allCategories = categoryService.getAllCategories();

        ApiResponse<List<Category>> apiResponse = new ApiResponse<>(true, allCategories);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

    @GetMapping("/regular-payments")
    public ResponseEntity<ApiResponse<List<RegularPayment>>> getRegularPayments() {

        List<RegularPayment> allRegularPayments = regularPaymentService.getAllRegularPayments();

        ApiResponse<List<RegularPayment>> apiResponse = new ApiResponse<>(true, allRegularPayments);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

}

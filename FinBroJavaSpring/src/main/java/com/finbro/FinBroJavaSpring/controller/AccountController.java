package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.Account;
import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.ApiResponse;
import com.finbro.FinBroJavaSpring.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/api/accounts")
@CrossOrigin(origins = "http://localhost")
public class AccountController {

    private final AccountService accountService;

    @Autowired
    public AccountController(AccountService accountService) {
        this.accountService = accountService;
    }

    @PostMapping("/addAccount")
    public ResponseEntity<ApiResponse<Account>> addAccount(@RequestBody Account account) {

        Account savedAccount = accountService.saveAccount(account);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, savedAccount));

    }

    @GetMapping("/allAccounts")
    public ResponseEntity<ApiResponse<List<Account>>> getAccounts() {

        List<Account> allAccounts = accountService.findAllAccounts();

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, allAccounts));

    }

    @GetMapping("/getById/{accountId}")
    public ResponseEntity<ApiResponse<Account>> getByAccountID(@PathVariable Long accountId) {

        Account account = accountService.findByAccountID(accountId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, account));

    }

    @GetMapping("/getAllByUserId/{userId}")
    public ResponseEntity<ApiResponse<List<Account>>> findAllByUserId(@PathVariable Long userId) {

        List<Account> userAccounts =  accountService.findAllByUserId(userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, userAccounts));

    }

    @PutMapping("/updateAccount")
    public ResponseEntity<ApiResponse<Account>> updateAccount(@RequestBody Account account) {

        Account updatedAccount = accountService.updateAccount(account);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, updatedAccount));

    }

    @DeleteMapping("/deleteById/{accountId}")
    public ResponseEntity<ApiResponse<?>> deleteAccount(@PathVariable Long accountId) {

        accountService.deleteAccountById(accountId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, null));

    }


}

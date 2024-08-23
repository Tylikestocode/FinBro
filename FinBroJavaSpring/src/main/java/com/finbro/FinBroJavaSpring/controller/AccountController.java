package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.Account;
import com.finbro.FinBroJavaSpring.exception.ApiResponse;
import com.finbro.FinBroJavaSpring.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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



    @PostMapping()
    public ResponseEntity<ApiResponse<Account>> createAccount(@RequestBody Account account) {

        Account savedAccount = accountService.createAccount(account);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, savedAccount));

    }

    @GetMapping()
    public ResponseEntity<ApiResponse<List<Account>>> getAccounts() {

        List<Account> allAccounts = accountService.getAllAccounts();

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, allAccounts));

    }

    @GetMapping("/{accountId}")
    public ResponseEntity<ApiResponse<Account>> getByAccountID(@PathVariable Long accountId) {

        Account account = accountService.getAccountById(accountId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, account));

    }

    @GetMapping("/userId/{userId}")
    public ResponseEntity<ApiResponse<List<Account>>> getAllByUserId(@PathVariable Long userId) {

        List<Account> userAccounts =  accountService.getAllByUserId(userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, userAccounts));

    }

    @PutMapping()
    public ResponseEntity<ApiResponse<Account>> updateAccount(@RequestBody Account account) {

        Account updatedAccount = accountService.updateAccount(account);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, updatedAccount));

    }

    @DeleteMapping("/{accountId}")
    public ResponseEntity<ApiResponse<?>> deleteById(@PathVariable Long accountId) {

        accountService.deleteAccountById(accountId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, null));

    }


}

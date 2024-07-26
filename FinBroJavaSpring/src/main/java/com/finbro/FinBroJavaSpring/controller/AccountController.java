package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.Account;
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

    @PostMapping("/addAccount")
    public ResponseEntity<?> addAccount(@RequestBody Account account) {

        Account savedAccount = accountService.saveAccount(account);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(savedAccount);

    }

    @GetMapping("/allAccounts")
    public List<Account> getAccounts() {

        return accountService.findAllAccounts();

    }

    @GetMapping("/getByAccountId/{accountId}")
    public ResponseEntity<?> getByAccountID(@PathVariable Long accountId) {

        Account account = accountService.findByAccountID(accountId);
        return ResponseEntity.ok(account);

    }

    @GetMapping("/getAllByUserId/{userId}")
    public List<Account> findAllByUserId(@PathVariable Long userId) {

        return accountService.findAllByUserId(userId);

    }

    @PutMapping("/updateAccount")
    public ResponseEntity<?> updateAccount(@RequestBody Account account) {

        Account updatedAccount = accountService.updateAccount(account);

        return ResponseEntity
                .ok(updatedAccount);

    }

    @DeleteMapping("/deleteById/{accountId}")
    public ResponseEntity<?> deleteAccount(@PathVariable Long accountId) {

        accountService.deleteAccountById(accountId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body("Account successfully deleted");

    }


}

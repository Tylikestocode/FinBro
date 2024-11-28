package com.yazeedmo.finbro.controller.mobile;

import com.yazeedmo.finbro.domain.Account;
import com.yazeedmo.finbro.domain.ApiResponse;
import com.yazeedmo.finbro.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/mobile/accounts")
@CrossOrigin(origins = "http://localhost")
public class MobileAccountController {

    private final AccountService accountService;

    @Autowired
    public MobileAccountController(AccountService accountService) {
        this.accountService = accountService;
    }



    @PostMapping()
    public ResponseEntity<ApiResponse<Account>> createAccount(@RequestBody Account account) {

        Account savedAccount = accountService.createAccount(account);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, savedAccount));

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

    @GetMapping("/userId-and-name")
    public ResponseEntity<ApiResponse<Account>> getByUserIdAndName(
            @RequestParam long userId,
            @RequestParam String accountName) {

        Account account = accountService.getByUserIdAndName(userId, accountName);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, account));
    }


    @GetMapping("/count-by-userId-and-name")
    public ResponseEntity<ApiResponse<Integer>> getCountByUserIdAndName(@RequestBody Map<String, String> requestData) {

        long userId = Long.parseLong(requestData.get("userId"));
        String accountName = requestData.get("accountName");

        int totalAccounts = accountService.getCountByUserIdAndName(userId, accountName);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, totalAccounts));

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

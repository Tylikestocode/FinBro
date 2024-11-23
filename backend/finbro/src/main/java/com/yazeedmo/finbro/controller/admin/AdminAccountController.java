package com.yazeedmo.finbro.controller.admin;

import com.yazeedmo.finbro.domain.Account;
import com.yazeedmo.finbro.domain.ApiResponse;
import com.yazeedmo.finbro.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admin/accounts")
@CrossOrigin(origins = "http://localhost")
public class AdminAccountController {

    private final AccountService accountService;

    @Autowired
    public AdminAccountController(AccountService accountService) {
        this.accountService = accountService;
    }



    @GetMapping()
    public ResponseEntity<ApiResponse<List<Account>>> getAccounts() {

        List<Account> allAccounts = accountService.getAllAccounts();

        ApiResponse<List<Account>> apiResponse = new ApiResponse<>(true, allAccounts);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

}

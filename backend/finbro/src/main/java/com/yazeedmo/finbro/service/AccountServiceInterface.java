package com.yazeedmo.finbro.service;

import com.yazeedmo.finbro.domain.Account;

import java.util.List;

// Breaks circular dependency between UserService and AccountService
public interface AccountServiceInterface {

    List<Account> getAllByUserId(Long userId);

}

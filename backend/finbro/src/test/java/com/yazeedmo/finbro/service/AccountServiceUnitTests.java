package com.yazeedmo.finbro.service;

import com.yazeedmo.finbro.domain.Account;
import com.yazeedmo.finbro.repository.AccountRepository;
import com.yazeedmo.finbro.repository.CategoryRepository;
import com.yazeedmo.finbro.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class AccountServiceUnitTests {

    @Mock
    private AccountRepository accountRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private CategoryRepository categoryRepository;

    @InjectMocks
    private AccountService accountService;

    private Account account1;

    @BeforeEach
    public void setUp() {

        accountRepository.deleteAll();

        account1 = new Account();
        account1.setName("Primary Account");
        account1.setAllowNegativeBalance(true);
        account1.setMinimumBalance(new BigDecimal(0));
        account1.setBalance(new BigDecimal(1000));
        account1.setDateCreated("02-10-2024");
        account1.setNotes("Daily Account");
        account1.setUserId(1L);
        account1.setCategoryId(1L);

    }

//    @Test
//    public void AccountService_CreateAccount_CreatesAccount() {
//
//        when(accountRepository.save(account1)).thenReturn(account1);
//        when(userRepository.existsById(account1.getUserId())).thenReturn(true);
//
//        Account createdAccount = accountService.createAccount(account1);
//
//        verify(accountRepository).save(account1);
//        assertThat(createdAccount).isNotNull();
//
//    }

}

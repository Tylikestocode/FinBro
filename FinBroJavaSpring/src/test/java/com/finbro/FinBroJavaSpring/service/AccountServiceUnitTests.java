package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.Account;
import com.finbro.FinBroJavaSpring.exception.MissingParameterException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NegativeBalanceException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NotesTooLongException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.UnderMinimumBalanceException;
import com.finbro.FinBroJavaSpring.exception.userexceptions.UserIDNotFoundException;
import com.finbro.FinBroJavaSpring.repository.AccountRepository;
import com.finbro.FinBroJavaSpring.repository.UserRepository;
import com.finbro.FinBroJavaSpring.util.DateTimeUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class AccountServiceUnitTests {

    @Mock
    private AccountRepository accountRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private AccountService accountService;

    private Account account1;
    private Account account2;
    private Account account3;

    @BeforeEach
    public void setUp() {

        account1 = new Account();
        account1.setId(1L);
        account1.setName("     Alice Savings     ");
        account1.setBalance(new BigDecimal("1000.00"));
        account1.setDateCreated("2024-01-01 10:00:00");
        account1.setMinimumBalance(new BigDecimal("500.00"));
        account1.setNotes("     Primary savings account");
        account1.setUserId(1L);
        account1.setCategoryId(1L);

        account2 = new Account();
        account2.setName("Bob Checking");
        account2.setBalance(new BigDecimal("1500.00"));
        account2.setDateCreated("2024-02-01 12:00:00");
        account2.setMinimumBalance(null);
        account2.setNotes("Main checking account");
        account2.setUserId(2L);
        account2.setCategoryId(null);

        account3 = new Account();
        account3.setName("Emily Investment");
        account3.setBalance(new BigDecimal("2000.00"));
        account3.setDateCreated("2024-03-01 14:00:00");
        account3.setMinimumBalance(new BigDecimal("1000.00"));
        account3.setName("Long-term investment account");
        account3.setUserId(3L);
        account3.setCategoryId(4L);

    }

    @Test
    public void AccountService_SaveAccount_ReturnsSavedAccount() {

        when(accountRepository.save(account1)).thenReturn(account1);
        when(userRepository.existsById(1L)).thenReturn(true);

        Account savedAccount = accountService.saveAccount(account1);

        verify(accountRepository).save(account1);
        assertThat(savedAccount).isNotNull();
        assertThat(savedAccount.getName()).isEqualTo("Alice Savings");

    }

    @Test
    public void AccountService_SaveAccount_ReturnsMissingParameterException_ForMissingName() {

        account1.setName(null);
        account2.setName("");

        assertThrows(MissingParameterException.class, () -> accountService.saveAccount(account1));
        assertThrows(MissingParameterException.class, () -> accountService.saveAccount(account2));

    }

    @Test
    public void AccountService_SaveAccount_ReturnsMissingParameterException_ForMissingUserId() {

        account1.setUserId(null);

        assertThrows(MissingParameterException.class, () -> accountService.saveAccount(account1));

    }

    @Test
    public void AccountService_SaveAccount_ReturnsUserIDNotFoundException_ForInvalidUserID() {

        when(userRepository.existsById(1L)).thenReturn(false);

        assertThrows(UserIDNotFoundException.class, () -> accountService.saveAccount(account1));

    }

    @Test
    public void AccountService_SaveAccount_ReturnsNegativeBalanceException() {

        when(userRepository.existsById(1L)).thenReturn(true);

        account1.setBalance(new BigDecimal("-120.00"));

        assertThrows(NegativeBalanceException.class, () -> accountService.saveAccount(account1));

    }

    @Test
    public void AccountService_SaveAccount_ReturnsUnderMinimumBalanceException() {

        when(userRepository.existsById(2L)).thenReturn(true);

        account2.setMinimumBalance(new BigDecimal("500.00"));
        account2.setBalance(new BigDecimal("300.00"));

        assertThrows(UnderMinimumBalanceException.class, () -> accountService.saveAccount(account2));

    }

    @Test
    public void AccountService_SaveAccount_ReturnsNotesTooLongException() {

        when(userRepository.existsById(3L)).thenReturn(true);

        String longNotes = "In the heart of the bustling city, where skyscrapers stretch toward the heavens and neon lights flicker with endless energy, lies a hidden garden—a serene oasis untouched by the chaos of urban life. This tranquil space, surrounded by high walls covered in ivy, offers a glimpse of nature's beauty amidst the concrete jungle. The garden features a variety of vibrant flowers, lush greenery, and a small, shimmering pond that reflects the sky like a mirror. Visitors can find solace here, taking a break from the relentless pace of city life. The gentle hum of bees and the melodic chirping of birds create a calming symphony, inviting everyone to slow down and appreciate the simple, yet profound, pleasures of nature. In this haven, time seems to stand still, allowing people to reconnect with themselves and the world around them. The garden serves as a reminder that even in the most hectic environments, pockets of peace and beauty can still exist, offering moments of respite and reflection.";
        account3.setNotes(longNotes);

        assertThrows(NotesTooLongException.class, () -> accountService.saveAccount(account3));

    }

    @Test
    public void AccountService_FindAllByUserId_ReturnsListOfUserAccounts() {

        when(accountRepository.findAllByUserId(1L)).thenReturn(List.of(account1, account2));

        List<Account> allUsersAccounts = accountRepository.findAllByUserId(1L);
        assertThat(allUsersAccounts).isNotNull();
        assertThat(allUsersAccounts.size()).isEqualTo(2);

    }

    @Test
    public void AccountService_FindAllByUserId_ReturnsUserIDNotFoundException() {

        when(userRepository.existsById(1L)).thenReturn(false);

        assertThrows(UserIDNotFoundException.class, () -> accountService.findAllByUserId(1L));

    }

    @Test
    public void AccountService_UpdateAccount_ReturnsUpdatedAccount() {

        when(userRepository.existsById(1L)).thenReturn(true);

        accountService.saveAccount(account1);

        account1.setId(1L);
        account1.setName("Updated Name");
        account1.setMinimumBalance(null);
        account1.setBalance(new BigDecimal("10"));

        when(accountRepository.save(account1)).thenReturn(account1);

        Account updatedAccount = accountService.updateAccount(account1);

        assertThat(updatedAccount).isNotNull();


    }

}

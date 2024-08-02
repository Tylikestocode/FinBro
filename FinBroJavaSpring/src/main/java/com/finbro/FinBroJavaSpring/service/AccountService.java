package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.Account;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.InvalidDateFormatException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.MissingParameterException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.AccountIDNotFoundException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NegativeBalanceException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NotesTooLongException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.UnderMinimumBalanceException;
import com.finbro.FinBroJavaSpring.exception.userexceptions.UserIDNotFoundException;
import com.finbro.FinBroJavaSpring.repository.AccountRepository;
import com.finbro.FinBroJavaSpring.repository.UserRepository;
import com.finbro.FinBroJavaSpring.util.DateTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class AccountService {

    private final AccountRepository accountRepository;
    private final UserRepository userRepository;

    public final static int MAX_NOTES_LENGTH = 500;

    @Autowired
    public AccountService(AccountRepository accountRepository, UserRepository userRepository) {
        this.accountRepository = accountRepository;
        this.userRepository = userRepository;
    }


    // Save Account
    public Account saveAccount(Account account) {

        // ID must be null
        if (account.getId() != null) {
            account.setId(null);
        }

        // Account name cannot be missing
        if (account.getName() == null || account.getName().isEmpty()) {
            throw new MissingParameterException("name");
        }

        // User ID cannot be missing
        if (account.getUserId() == null) {
            throw new MissingParameterException("user id");
        }

        // User ID must exist in Users table
        if (!userRepository.existsById(account.getUserId())) {
            throw new UserIDNotFoundException(String.valueOf(account.getUserId()));
        }

        // Check Category id when Category is implemented

        // Balance cannot be less than 0
        if ((account.getBalance() != null) && (account.getBalance().compareTo(BigDecimal.ZERO) < 0)) {
            throw new NegativeBalanceException(String.valueOf(account.getBalance()));
        }

        // MinimumBalance cannot be less than 0
        if ((account.getMinimumBalance() != null) && (account.getMinimumBalance().compareTo(BigDecimal.ZERO) < 0)) {
            throw new NegativeBalanceException(String.valueOf(account.getMinimumBalance()));
        }

        // If minimum balance is set, balance cannot be less that minimum balance
        if ((account.getMinimumBalance() != null) && account.getBalance().compareTo(account.getMinimumBalance()) < 0) {
            throw new UnderMinimumBalanceException(String.valueOf(account.getBalance()));
        }

        // If no date created is set, set date created to current date
        if (account.getDateCreated() == null) {
            account.setDateCreated(DateTimeUtil.convertDateTimeToString(LocalDateTime.now()));
        }
        else {
            if (!DateTimeUtil.isValidDateTimeFormat(account.getDateCreated())) {
                throw new InvalidDateFormatException(account.getDateCreated());
            }
        }

        // Notes cannot be more than 500 characters
        if (account.getNotes() != null && account.getNotes().length() > MAX_NOTES_LENGTH) {
            throw new NotesTooLongException(String.valueOf(account.getNotes().length()));
        }

        trimStringData(account);

        return accountRepository.save(account);

    }

    // Get all Accounts
    public List<Account> findAllAccounts() {
        return (List<Account>) accountRepository.findAll();
    }

    // Get Accounts by User ID
    public Account findByAccountID(Long accountId) {

        if (!accountRepository.existsById(accountId)) {
            throw new AccountIDNotFoundException(String.valueOf(accountId));
        }

        return accountRepository.findById(accountId).orElse(null);

    }

    // Get all Accounts by User ID
    public List<Account> findAllByUserId(Long userId) {

        if (!userRepository.existsById(userId)) {
            throw new  UserIDNotFoundException(String.valueOf(userId));
        }

        return accountRepository.findAllByUserId(userId);

    }

    // Update Account
    public Account updateAccount(Account account) {

        // ID must not be null
        if (account.getId() == null) {
            throw new MissingParameterException("id");
        }

        // Account name cannot be missing
        if (account.getName() == null || account.getName().isEmpty()) {
            throw new MissingParameterException("name");
        }

        // User ID cannot be missing
        if (account.getUserId() == null) {
            throw new MissingParameterException("user id");
        }

        // User ID must exist in Users table
        if (!userRepository.existsById(account.getUserId())) {
            throw new UserIDNotFoundException(String.valueOf(account.getUserId()));
        }

        // Check Category id when Category is implemented

        // Balance cannot be less than 0
        if ((account.getBalance() != null) && (account.getBalance().compareTo(BigDecimal.ZERO) < 0)) {
            throw new NegativeBalanceException(String.valueOf(account.getBalance()));
        }

        // If minimum balance is set, balance cannot be less that minimum balance
        if ((account.getMinimumBalance() != null) && account.getBalance().compareTo(account.getMinimumBalance()) < 0) {
            throw new UnderMinimumBalanceException(String.valueOf(account.getBalance()));
        }

        // If no date created is set, set date created to current date
        if (account.getDateCreated() == null) {
            account.setDateCreated(DateTimeUtil.convertDateTimeToString(LocalDateTime.now()));
        }
        else {
            if (!DateTimeUtil.isValidDateTimeFormat(account.getDateCreated())) {
                throw new InvalidDateFormatException(account.getDateCreated());
            }
        }

        // Notes cannot be more than 500 characters
        if (account.getNotes() != null && account.getNotes().length() > MAX_NOTES_LENGTH) {
            throw new NotesTooLongException(String.valueOf(account.getNotes().length()));
        }

        trimStringData(account);

        return accountRepository.save(account);

    }

    // Delete Account
    public void deleteAccountById(Long id) {

        if (!accountRepository.existsById(id)) {
            throw new AccountIDNotFoundException(String.valueOf(id));
        }

        accountRepository.deleteById(id);
    }


    // HELPER METHODS

    private void trimStringData(Account account) {

        account.setName(account.getName().trim());
        account.setNotes(account.getNotes().trim());

    }

}

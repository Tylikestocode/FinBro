package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.Account;
import com.finbro.FinBroJavaSpring.domain.Transaction;
import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.*;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.InvalidDataFormatException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.MissingParameterException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.ResourceNotFoundException;
import com.finbro.FinBroJavaSpring.repository.AccountRepository;
import com.finbro.FinBroJavaSpring.repository.CategoryRepository;
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
    private final CategoryRepository categoryRepository;

    public final static int MAX_NOTES_LENGTH = 500;

    @Autowired
    public AccountService(
            AccountRepository accountRepository,
            UserRepository userRepository,
            CategoryRepository categoryRepository) {
        this.accountRepository = accountRepository;
        this.userRepository = userRepository;
        this.categoryRepository = categoryRepository;
    }



    public Account createAccount(Account account) {

        validateAccount(account, true);

        return accountRepository.save(account);

    }

    public List<Account> getAllAccounts() {
        return (List<Account>) accountRepository.findAll();
    }

    public Account getAccountById(Long accountId) {

        if (!accountRepository.existsById(accountId)) {
            throw new ResourceNotFoundException(Account.class, "id", String.valueOf(accountId));
        }

        return accountRepository.findById(accountId).orElse(null);

    }

    public List<Account> getAllByUserId(Long userId) {

        if (!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(userId));
        }

        return accountRepository.findAllByUserId(userId);

    }

    public Account updateAccount(Account account) {

        validateAccount(account, false);

        return accountRepository.save(account);

    }

    public void deleteAccountById(Long id) {

        if (!accountRepository.existsById(id)) {
            throw new ResourceNotFoundException(Account.class, "id", String.valueOf(id));
        }

        accountRepository.deleteById(id);
    }


    // HELPER METHODS

    // All validation happens in one function
    private void validateAccount(Account account, boolean isNew) {

        // Validation when adding a new Account
        if (isNew) {

            // ID for new Account must be null -> database auto generates new ID's
            if (account.getId() != null) {
                account.setId(null);
            }

        }
        else {

            // Account ID must not be null
            if (account.getId() == null) {
                throw new MissingParameterException("id");
            }

            // Account ID must exist in Accounts table
            if (!accountRepository.existsById(account.getId())) {
                throw new ResourceNotFoundException(Account.class, "id", String.valueOf(account.getId()));
            }

        }

        // Validation regardless if account is new or not
        validateAccountName(account);
        validateUserId(account);
        validateBalance(account);
        validateDate(account);
        validateNotes(account);
        validateCategory(account);
        trimStringData(account);

    }

    private void trimStringData(Account account) {

        account.setName(account.getName().trim());
        account.setNotes(account.getNotes().trim());

    }

    private void validateAccountName(Account account) {

        // Account name cannot be null
        if (account.getName() == null || account.getName().isEmpty()) {
            throw new MissingParameterException("name");
        }

        // Other possible checks in the future

    }

    private void validateUserId(Account account) {

        // User ID cannot be missing
        if (account.getUserId() == null) {
            throw new MissingParameterException("user Id");
        }

        // User ID must exist in Users table
        if (!userRepository.existsById(account.getUserId())) {
            throw new ResourceNotFoundException(Account.class, "UserId", String.valueOf(account.getUserId()));
        }

    }

    private void validateBalance(Account account) {

        // Balance cannot be less than 0
        if (account.getBalance() != null && account.getBalance().compareTo(BigDecimal.ZERO) < 0) {
            throw new NegativeBalanceException(String.valueOf(account.getBalance()));
        }

        // Minimum balance cannot be less than 0
        if (account.getMinimumBalance() != null && account.getMinimumBalance().compareTo(BigDecimal.ZERO) < 0) {
            throw new NegativeBalanceException(String.valueOf(account.getMinimumBalance()));
        }

        // If minimum balance is set, balance cannot be less than minimum balance
        if (account.getMinimumBalance() != null && account.getBalance().compareTo(account.getMinimumBalance()) < 0) {
            throw new UnderMinimumBalanceException(String.valueOf(account.getBalance()));
        }

    }

    private void validateDate(Account account) {

        // If no dateCreated is set, set dateCreated to current date
        if (account.getDateCreated() == null) {
            account.setDateCreated(DateTimeUtil.convertDateTimeToString(LocalDateTime.now()));
        }
        else {
            if (DateTimeUtil.isValidDateTimeFormat(account.getDateCreated())) {
                throw new InvalidDataFormatException("dateCreated", account.getDateCreated(), DateTimeUtil.DATE_TIME_FORMAT);
            }
        }

    }

    private void validateNotes(Account account) {

        if (account.getNotes() != null && account.getNotes().length() > MAX_NOTES_LENGTH) {
            throw new NotesTooLongException(String.valueOf(account.getNotes().length()));
        }

        // Other possible checks in the future

    }

    private void validateCategory(Account account) {

        if (!categoryRepository.existsById(account.getCategoryId())) {
            throw new ResourceNotFoundException(Transaction.class, "CategoryId", String.valueOf(account.getCategoryId()));
        }

    }

}

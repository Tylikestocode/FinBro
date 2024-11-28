package com.yazeedmo.finbro.service;

import com.yazeedmo.finbro.domain.Account;
import com.yazeedmo.finbro.domain.AdminEvent;
import com.yazeedmo.finbro.domain.Transaction;
import com.yazeedmo.finbro.domain.User;
import com.yazeedmo.finbro.exception.account.*;
import com.yazeedmo.finbro.exception.general.InvalidDataFormatException;
import com.yazeedmo.finbro.exception.general.MissingParameterException;
import com.yazeedmo.finbro.exception.general.ResourceAlreadyExistsException;
import com.yazeedmo.finbro.exception.general.ResourceNotFoundException;
import com.yazeedmo.finbro.repository.AccountRepository;

import com.yazeedmo.finbro.util.DateTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@SuppressWarnings("BooleanMethodIsAlwaysInverted")
@Service
public class AccountService {

    private final AccountRepository accountRepository;

    private final UserService userService;
    private final CategoryService categoryService;
    private final WebSocketService webSocketService;

    public final static int MAX_NOTES_LENGTH = 500;

    @Autowired
    public AccountService(
            AccountRepository accountRepository,
            UserService userService,
            CategoryService categoryService,
            WebSocketService webSocketService
    ) {
        this.accountRepository = accountRepository;
        this.userService = userService;
        this.categoryService = categoryService;
        this.webSocketService = webSocketService;
    }



    public Account createAccount(Account account) {

        validateAccount(account, true);

        Account newAccount = accountRepository.save(account);
        sendAccountsAdminUpdate();

        return newAccount;

    }

    public List<Account> getAllAccounts() {
        return (List<Account>) accountRepository.findAll();
    }

    public long getCountTotalAccounts() {
        return accountRepository.countTotalAccounts();
    }

    public Account getAccountById(Long accountId) {

        if (!accountRepository.existsById(accountId)) {
            throw new ResourceNotFoundException(Account.class, "id", String.valueOf(accountId));
        }

        return accountRepository.findById(accountId).orElse(null);

    }

    public boolean existsById(Long accountId) {
        return accountRepository.existsById(accountId);
    }

    public List<Account> getAllByUserId(Long userId) {

        if (!userService.existsById(userId)) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(userId));
        }

        return accountRepository.findAllByUserId(userId);

    }

    public Account getByUserIdAndName(long userId, String name) {

        if (!userService.existsById(userId)) {
            throw new ResourceNotFoundException(Account.class, "userId", String.valueOf(userId));
        }

        Optional<Account> account = accountRepository.findByUserIdAndName(userId, name);

        if (account.isEmpty()) {
            throw new ResourceNotFoundException(Account.class, "AccountName", String.valueOf(name));
        }

        return account.get();

    }

    public int getCountByUserIdAndName(long userId, String name) {

        if (!userService.existsById(userId)) {
            throw new ResourceNotFoundException(Account.class, "UserId", String.valueOf(userId));
        }

        return accountRepository.countByUserIdAndName(userId, name);

    }

    public Account updateAccount(Account account) {

        validateAccount(account, false);

        Account updatedAccount = accountRepository.save(account);
        sendAccountsAdminUpdate();

        return updatedAccount;

    }

    public void deleteAccountById(Long id) {

        if (!accountRepository.existsById(id)) {
            throw new ResourceNotFoundException(Account.class, "id", String.valueOf(id));
        }

        accountRepository.deleteById(id);

        sendAccountsAdminUpdate();
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

            validateAccountName(account);

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

            // If account name is changing, first check if account name already exists
            Account originalAccount = getAccountById(account.getId());
            if (!originalAccount.getName().equals(account.getName())) {
                int numAccountsWithNewName = getCountByUserIdAndName(account.getUserId(), account.getName());
                if (numAccountsWithNewName > 0) {
                    throw new ResourceAlreadyExistsException(Account.class, "Account Name", account.getName());
                }
            }


        }

        // Validation regardless if account is new or not
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

        int numAccountsWithName = getCountByUserIdAndName(account.getUserId(), account.getName());

        if (numAccountsWithName > 0) {
            throw new ResourceAlreadyExistsException(Account.class, "Account Name", account.getName());
        }

    }

    private void validateUserId(Account account) {

        // User ID cannot be missing
        if (account.getUserId() == null) {
            throw new MissingParameterException("user Id");
        }

        // User ID must exist in Users table
        if (!userService.existsById(account.getUserId())) {
            throw new ResourceNotFoundException(Account.class, "UserId", String.valueOf(account.getUserId()));
        }

    }

    private void validateBalance(Account account) {

        if (account.getMinimumBalance() != null) {
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

        if (!categoryService.existsById(account.getCategoryId())) {
            throw new ResourceNotFoundException(Transaction.class, "CategoryId", String.valueOf(account.getCategoryId()));
        }

    }

    private void sendAccountsAdminUpdate() {
        AdminEvent adminEvent = new AdminEvent(AdminEvent.EventType.ACCOUNTS_UPDATED);
        webSocketService.sendAdminUpdate(adminEvent);
    }

}

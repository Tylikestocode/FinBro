package com.yazeedmo.finbro.service;

import com.yazeedmo.finbro.domain.Account;
import com.yazeedmo.finbro.domain.Transaction;
import com.yazeedmo.finbro.domain.User;
import com.yazeedmo.finbro.exception.account.NegativeBalanceException;
import com.yazeedmo.finbro.exception.account.NotesTooLongException;
import com.yazeedmo.finbro.exception.account.UnderMinimumBalanceException;
import com.yazeedmo.finbro.exception.general.InvalidDataFormatException;
import com.yazeedmo.finbro.exception.general.MissingParameterException;
import com.yazeedmo.finbro.exception.general.ResourceNotFoundException;
import com.yazeedmo.finbro.exception.general.ServerErrorException;
import com.yazeedmo.finbro.exception.transaction.DescTooLongException;

import com.yazeedmo.finbro.repository.TransactionRepository;
import com.yazeedmo.finbro.util.DateTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class TransactionService {

    private final TransactionRepository transactionRepository;

    private final UserService userService;
    private final AccountService accountService;
    private final CategoryService categoryService;

    public final static int MAX_NOTES_LENGTH = 500;
    public final static int MAX_DESC_LENGTH = 500;

    @Autowired
    public TransactionService(
            TransactionRepository transactionRepository,
            UserService userService,
            AccountService accountService,
            CategoryService categoryService
    ) {
        this.transactionRepository = transactionRepository;
        this.userService = userService;
        this.accountService = accountService;
        this.categoryService = categoryService;

    }


    public Transaction createTransaction(Transaction transaction) {

        validateTransaction(transaction, true);

        // Before commiting Transaction - Make sure Transaction and Account will be valid
        if (validAmount(transaction)) {
            return performTransaction(transaction);
        }

        return null;

    }

    public List<Transaction> getAllTransactions() {

        List<Transaction> allTransactions = (List<Transaction>) transactionRepository.findAll();

        for (Transaction transaction : allTransactions) {
            transaction.setDate(DateTimeUtil.convertDBTimeToString(transaction.getDate()));
        }

        return allTransactions;
    }

    public Transaction getTransactionById(Long transactionId) {

        if (!transactionRepository.existsById(transactionId)) {
            throw new ResourceNotFoundException(Transaction.class, "id", String.valueOf(transactionId));
        }

        return transactionRepository.findById(transactionId).orElse(null);

    }

    public List<Transaction> getAllByUserId(Long userId) {

        if (!userService.existsById(userId)) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(userId));
        }

        return transactionRepository.findAllByUserId(userId);

    }

    public List<Transaction> getAllByAccountId(Long accountId) {

        if (!accountService.existsById(accountId)) {
            throw new ResourceNotFoundException(Account.class, "id", String.valueOf(accountId));
        }

        return transactionRepository.findAllByAccountId(accountId);

    }

    public Transaction updateTransaction(Transaction transaction) {

        validateTransaction(transaction, false);

        if (validAmount(transaction)) {
            return performTransaction(transaction);
        }

        throw new ServerErrorException("A weird error happened while trying to service a Transaction");

    }

    public void deleteByTransactionId(Long id) {

        if (!transactionRepository.existsById(id)) {
            throw new ResourceNotFoundException(Transaction.class, "id", String.valueOf(id));
        }

        transactionRepository.deleteById(id);

    }


    // HELPER METHODS

    // All validation happens in one function
    private void validateTransaction(Transaction transaction, boolean isNew) {

        // Validation when adding a new Transaction
        if (isNew) {

            // ID for new Transaction must be null -> database auto generates new ID's
            if (transaction.getId() != null) {
                transaction.setAccountId(null);
            }

        }
        else {

            // Transaction ID must not be null
            if (transaction.getId() == null) {
                throw new MissingParameterException("id");
            }

            // Transaction ID must exist in Transactions table
            if (!transactionRepository.existsById(transaction.getId())) {
                throw new ResourceNotFoundException(Transaction.class, "id", String.valueOf(transaction.getId()));
            }

        }

        // Validation regardless if account is new or not
        validateDescription(transaction);
        validateDate(transaction);
        validateNotes(transaction);
        validateUserId(transaction);
        validateAccountId(transaction);
        validateCategoryId(transaction);
        trimStringData(transaction);

    }

    private void trimStringData(Transaction transaction) {

        transaction.setDescription(transaction.getDescription().trim());
        transaction.setNotes(transaction.getNotes().trim());

    }

    private boolean validAmount(Transaction transaction) {

        BigDecimal transactionAmount = transaction.getAmount();
        Account account = accountService.getAccountById(transaction.getAccountId());
        BigDecimal currentAccountAmount;
        BigDecimal minimumBalance;
        boolean allowNegativeBalance;

        if (account != null) {
            currentAccountAmount = account.getBalance();
            minimumBalance = account.getMinimumBalance();
            allowNegativeBalance = account.isAllowNegativeBalance();
        }
        else {
            throw new ServerErrorException("Cannot validate transaction. Failed to find account");
        }

        BigDecimal finalAmount = currentAccountAmount.add(transactionAmount);

        if ((finalAmount.compareTo(new BigDecimal(0)) < 0) && !allowNegativeBalance) {
            throw new NegativeBalanceException(String.valueOf(finalAmount));
        }

        if (finalAmount.compareTo(minimumBalance) < 0) {
            throw new UnderMinimumBalanceException(String.valueOf(finalAmount));
        }

        return true;

    }

    private void validateDescription(Transaction transaction) {

        if (transaction.getNotes() != null && transaction.getNotes().length() > MAX_DESC_LENGTH) {
            throw new DescTooLongException(String.valueOf(transaction.getDescription().length()));
        }

    }

    private void validateDate(Transaction transaction) {

        if (transaction.getDate() == null) {
            transaction.setDate(DateTimeUtil.convertDateTimeToString(LocalDateTime.now()));
        }
        else {
            if (DateTimeUtil.isValidDateTimeFormat(transaction.getDate())) {
                throw new InvalidDataFormatException("date", transaction.getDate(), DateTimeUtil.DATE_TIME_FORMAT);
            }
        }

    }

    private void validateNotes(Transaction transaction) {

        if (transaction.getNotes() != null && transaction.getNotes().length() > MAX_NOTES_LENGTH) {
            throw new NotesTooLongException(String.valueOf(transaction.getNotes().length()));
        }

    }

    private void validateUserId(Transaction transaction) {

        if (transaction.getUserId() == null) {
            throw new MissingParameterException("UserId");
        }

        if (!userService.existsById(transaction.getUserId())) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(transaction.getUserId()));
        }

    }

    private void validateAccountId(Transaction transaction) {

        if (transaction.getAccountId() == null) {
            throw new MissingParameterException("AccountId");
        }
        if (!accountService.existsById(transaction.getAccountId())) {
            throw new ResourceNotFoundException(Account.class, "id", String.valueOf(transaction.getAccountId()));
        }

    }

    private void validateCategoryId(Transaction transaction) {

        if (!categoryService.existsById(transaction.getCategoryId())) {
            throw new ResourceNotFoundException(Transaction.class, "CategoryId", String.valueOf(transaction.getCategoryId()));
        }

    }

    @Transactional
    private Transaction performTransaction(Transaction transaction) {

        BigDecimal transactionAmount = transaction.getAmount();
        Account account = accountService.getAccountById(transaction.getAccountId());

        boolean allowNegativeBalance;
        BigDecimal minimumBalance = null;
        BigDecimal currentAccountAmount;

        if (account != null) {
            allowNegativeBalance = account.isAllowNegativeBalance();
            if (account.getMinimumBalance() != null) {
                minimumBalance = account.getMinimumBalance();
            }
            currentAccountAmount = account.getBalance();
        }
        else {
            throw new ServerErrorException("Cannot perform transaction. Failed to find account");
        }

        BigDecimal finalAmount = currentAccountAmount.add(transactionAmount);

        // Exception if negative balance is not allowed and finalAmount is below zero
        if ((finalAmount.compareTo(new BigDecimal(0)) < 0) && !allowNegativeBalance) {
            throw new NegativeBalanceException(String.valueOf(finalAmount));
        }

        // Exception if finalAmount is below minimumBalance
        if (finalAmount.compareTo(minimumBalance) < 0) {
            throw new UnderMinimumBalanceException(String.valueOf(finalAmount));
        }

        // Everything is valid -> Save new Transaction and update relevant tables
        Transaction savedTransaction = transactionRepository.save(transaction);
        account.setBalance(finalAmount);
        accountService.createAccount(account);

        savedTransaction.setDate(DateTimeUtil.convertDBTimeToString(savedTransaction.getDate()));

        return savedTransaction;


    }

}

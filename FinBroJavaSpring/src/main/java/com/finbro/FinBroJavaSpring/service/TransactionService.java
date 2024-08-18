package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.Account;
import com.finbro.FinBroJavaSpring.domain.Transaction;
import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NegativeBalanceException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NotesTooLongException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.UnderMinimumBalanceException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.InvalidDataFormatException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.MissingParameterException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.ResourceNotFoundException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.ServerErrorException;
import com.finbro.FinBroJavaSpring.exception.transactionexceptions.DescTooLongException;
import com.finbro.FinBroJavaSpring.repository.AccountRepository;
import com.finbro.FinBroJavaSpring.repository.TransactionRepository;
import com.finbro.FinBroJavaSpring.repository.UserRepository;
import com.finbro.FinBroJavaSpring.util.DateTimeUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class TransactionService {

    private final TransactionRepository transactionRepository;
    private final UserRepository userRepository;
    private final AccountRepository accountRepository;

    public final static int MAX_NOTES_LENGTH = 500;
    public final static int MAX_DESC_LENGTH = 500;

    Logger logger = LoggerFactory.getLogger(TransactionService.class);

    @Autowired
    public TransactionService(TransactionRepository transactionRepository, UserRepository userRepository, AccountRepository accountRepository) {
        this.transactionRepository = transactionRepository;
        this.userRepository = userRepository;
        this.accountRepository = accountRepository;
    }


    public Transaction saveTransaction(Transaction transaction) {

        validateTransaction(transaction, true);

        // Before commiting Transaction - Make sure Transaction and Account will be valid
        if (validAmount(transaction)) {
            return performTransaction(transaction);
        }

        return null;

    }

    public List<Transaction> findAllTransactions() {

        List<Transaction> allTransactions = (List<Transaction>) transactionRepository.findAll();

        for (Transaction transaction : allTransactions) {
            transaction.setDate(DateTimeUtil.convertDBTimeToString(transaction.getDate()));
        }

        return allTransactions;
    }

    public Transaction findByTransactionId(Long transactionId) {

        if (!transactionRepository.existsById(transactionId)) {
            throw new ResourceNotFoundException(Transaction.class, "id", String.valueOf(transactionId));
        }

        return transactionRepository.findById(transactionId).orElse(null);

    }

    public List<Transaction> findAllByUserId(Long userId) {

        if (!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(userId));
        }

        return transactionRepository.findAllTransactionsByUserId(userId);

    }

    public List<Transaction> findAllByAccountId(Long accountId) {

        if (!accountRepository.existsById(accountId)) {
            throw new ResourceNotFoundException(Account.class, "id", String.valueOf(accountId));
        }

        return transactionRepository.findAllTransactionsByAccountId(accountId);

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
        Account account = accountRepository.findById(transaction.getAccountId()).orElse(null);
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

        if (transaction.getNotes() != null && transaction.getNotes().length() > MAX_NOTES_LENGTH) {
            throw new DescTooLongException(String.valueOf(transaction.getDescription().length()));
        }

    }

    private void validateDate(Transaction transaction) {

        if (transaction.getDate() == null) {
            transaction.setDate(DateTimeUtil.convertDateTimeToString(LocalDateTime.now()));
        }
        else {
            if (!DateTimeUtil.isValidDateTimeFormat(transaction.getDate())) {
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

        if (!userRepository.existsById(transaction.getUserId())) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(transaction.getUserId()));
        }

    }

    private void validateAccountId(Transaction transaction) {

        if (transaction.getAccountId() == null) {
            throw new MissingParameterException("AccountId");
        }
        if (!accountRepository.existsById(transaction.getAccountId())) {
            throw new ResourceNotFoundException(Account.class, "id", String.valueOf(transaction.getAccountId()));
        }

    }

    private void validateCategoryId(Transaction transaction) {

        // TODO: Add validation logic after implementing Categories

    }

    @Transactional
    private Transaction performTransaction(Transaction transaction) {

        BigDecimal transactionAmount = transaction.getAmount();
        Account account = accountRepository.findById(transaction.getAccountId()).orElse(null);

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
        accountRepository.save(account);

        savedTransaction.setDate(DateTimeUtil.convertDBTimeToString(savedTransaction.getDate()));

        return savedTransaction;


    }

}

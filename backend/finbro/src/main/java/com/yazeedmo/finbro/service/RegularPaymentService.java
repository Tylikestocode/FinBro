package com.yazeedmo.finbro.service;

import com.yazeedmo.finbro.domain.AdminEvent;
import com.yazeedmo.finbro.domain.Category;
import com.yazeedmo.finbro.domain.RegularPayment;
import com.yazeedmo.finbro.domain.Transaction;
import com.yazeedmo.finbro.exception.account.NotesTooLongException;
import com.yazeedmo.finbro.exception.general.*;
import com.yazeedmo.finbro.repository.RegularPaymentRepository;
import com.yazeedmo.finbro.util.DateTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

@Service
public class RegularPaymentService {

    private final RegularPaymentRepository regularPaymentRepository;

    private final TransactionService transactionService;
    private final UserService userService;
    private final AccountService accountService;
    private final CategoryService categoryService;
    private final WebSocketService webSocketService;


    public final static int MAX_NOTES_LENGTH = 500;

    @Autowired
    public RegularPaymentService(
            RegularPaymentRepository regularPaymentRepository,
            TransactionService transactionService,
            UserService userService,
            AccountService accountService,
            CategoryService categoryService,
            WebSocketService webSocketService
    ) {
        this.transactionService = transactionService;
        this.regularPaymentRepository = regularPaymentRepository;
        this.userService = userService;
        this.accountService = accountService;
        this.categoryService = categoryService;
        this.webSocketService = webSocketService;
    }



    @Scheduled(cron = "0 0 0 * * *")
    public void processDuePayments() {

        LocalDateTime today = LocalDateTime.now();
        List<RegularPayment> duePayments = regularPaymentRepository.findDuePayments(today);

        for (RegularPayment regularPayment : duePayments) {

            Transaction transaction = new Transaction();
            transaction.setAmount(regularPayment.getAmount());
            transaction.setDescription(regularPayment.getName());
            transaction.setDate(DateTimeUtil.convertDateTimeToString(today));
            transaction.setUserId(regularPayment.getUserId());
            transaction.setAccountId(regularPayment.getAccountId());
            if (regularPayment.getCategoryId() != null) {
                transaction.setCategoryId(regularPayment.getCategoryId());
            }

            transactionService.createTransaction(transaction);

            switch (regularPayment.getFrequency()) {
                case "DAILY":
                    regularPayment.setNextDate(
                            DateTimeUtil.convertDateTimeToString(
                                    LocalDateTime.now().plusDays(1)
                            ));
                    break;
                case "WEEKLY":
                    regularPayment.setNextDate(
                            DateTimeUtil.convertDateTimeToString(
                                    LocalDateTime.now().plusWeeks(1)
                            ));
                    break;
                case "MONTHLY":
                    regularPayment.setNextDate(
                            DateTimeUtil.convertDateTimeToString(
                                    LocalDateTime.now().plusMonths(1)
                            ));
                    break;
                case "YEARLY":
                    regularPayment.setNextDate(
                            DateTimeUtil.convertDateTimeToString(
                                    LocalDateTime.now().plusYears(1)
                            ));
                    break;

            }

        }

    }



    public RegularPayment createRegularPayment(RegularPayment regularPayment) {

        validateRegularPayment(regularPayment, true);

        return regularPaymentRepository.save(regularPayment);

    }

    public List<RegularPayment> getAllRegularPayments() {

        return (List<RegularPayment>) regularPaymentRepository.findAll();

    }

    public RegularPayment getRegularPaymentById(Long regularPaymentId) {

        if (!regularPaymentRepository.existsById(regularPaymentId)) {
            throw new ResourceNotFoundException(RegularPayment.class, "id", String.valueOf(regularPaymentId));
        }

        return regularPaymentRepository.findById(regularPaymentId).orElse(null);

    }

    public List<RegularPayment> getAllByUserId(Long userId) {

        return regularPaymentRepository.findAllByUserId(userId);

    }

    public List<RegularPayment> getAllDuePayments(LocalDateTime date) {

        return regularPaymentRepository.findDuePayments(date);

    }

    public RegularPayment updateRegularPayment(RegularPayment regularPayment) {

        validateRegularPayment(regularPayment, false);

        return regularPaymentRepository.save(regularPayment);

    }

    public void deleteRegularPaymentById(Long id) {

        if (!regularPaymentRepository.existsById(id)) {
            throw new ResourceNotFoundException(RegularPayment.class, "id", String.valueOf(id));
        }

        regularPaymentRepository.deleteById(id);

    }



    // HELPER METHODS

    // All validation happens in one function
    private void validateRegularPayment(RegularPayment regularPayment, boolean isNew) {

        if (isNew) {

            if (regularPayment.getId() != null) {
                regularPayment.setId(null);
            }

            validateName(regularPayment);

        }
        else {

            // RegularPayment ID must not be null
            if (regularPayment.getId() == null) {
                throw new MissingParameterException("id");
            }

            // RegularPayment ID must exist in RegularPayments table
            if (!regularPaymentRepository.existsById(regularPayment.getId())) {
                throw new ResourceNotFoundException(RegularPayment.class, "id", String.valueOf(regularPayment.getId()));
            }

            RegularPayment existingRegularPayment = regularPaymentRepository.findById(regularPayment.getId()).orElse(null);

            if (existingRegularPayment != null) {
                // If name is changing, first check if name already exists
                if (existingRegularPayment.getName().equals(regularPayment.getName())) {
                    // Do nothing
                    return;
                }
                else {
                    validateName(regularPayment);
                }
            }
            else {
                throw new ServerErrorException("Error in RegularPaymentService");
            }



        }

        validateUserId(regularPayment);
        validateAccountId(regularPayment);
        validateCategoryId(regularPayment);
        validateNotes(regularPayment);
        validateEndDate(regularPayment);
        validateNextDate(regularPayment);
        validateFrequency(regularPayment);

    }

    private void validateUserId(RegularPayment regularPayment) {

        if (regularPayment.getUserId() == null) {
            throw new MissingParameterException("UserId");
        }

        if (!userService.existsById(regularPayment.getUserId())) {
            throw new ResourceNotFoundException(RegularPayment.class, "userId", String.valueOf(regularPayment.getUserId()));
        }

    }

    private void validateAccountId(RegularPayment regularPayment) {

        if (regularPayment.getAccountId() == null) {
            throw new MissingParameterException("AccountId");
        }

        if(!accountService.existsById(regularPayment.getAccountId())) {
            throw new ResourceNotFoundException(RegularPayment.class, "accountId", String.valueOf(regularPayment.getAccountId()));
        }

    }

    private void validateCategoryId(RegularPayment regularPayment) {

        if (regularPayment.getCategoryId() == null) {
            // Do nothing
            return;
        }

        System.out.println(regularPayment.getCategoryId());

        if (!categoryService.existsById(regularPayment.getCategoryId())) {
            throw new ResourceNotFoundException(Category.class, "CategoryId", String.valueOf(regularPayment.getCategoryId()));
        }

    }

    private void validateNotes(RegularPayment regularPayment) {

        if (regularPayment.getNotes() != null && regularPayment.getNotes().length() > MAX_NOTES_LENGTH) {
            throw new NotesTooLongException(String.valueOf(regularPayment.getNotes().length()));
        }

    }

    public void validateNextDate(RegularPayment regularPayment) {

        if (regularPayment.getNextDate() == null) {
            throw new MissingParameterException("next_occurrence_date");
        }

        if (!DateTimeUtil.isValidDateTimeFormat(regularPayment.getNextDate())) {
            throw new InvalidDataFormatException(
                    "nextDate",
                    regularPayment.getNextDate(),
                    DateTimeUtil.DATE_TIME_FORMAT);
        }

        LocalDate now = LocalDateTime.now().toLocalDate();
        LocalDate nextDate = Objects.requireNonNull(DateTimeUtil.convertStringToDateTime(regularPayment.getNextDate())).toLocalDate();

        if (nextDate != null) {
            if (nextDate.isBefore(now)) {
                throw new InvalidDataFormatException("nextDate", regularPayment.getNextDate(), "Next date cannot be before current date");
            }
        }
        else {
            throw new InvalidDataFormatException(
                    "nextDate",
                    regularPayment.getNextDate(),
                    DateTimeUtil.DATE_TIME_FORMAT);
        }

    }

    private void validateEndDate(RegularPayment regularPayment) {

        if (regularPayment.getEndDate() == null) {
            // Do nothing
            return;
        }

        if (!DateTimeUtil.isValidDateTimeFormat(regularPayment.getEndDate())) {
            throw new InvalidDataFormatException(
                    "endDate",
                    regularPayment.getEndDate(),
                    DateTimeUtil.DATE_TIME_FORMAT);
        }

        LocalDate now = LocalDateTime.now().toLocalDate();
        LocalDate nextDate = Objects.requireNonNull(DateTimeUtil.convertStringToDateTime(regularPayment.getNextDate())).toLocalDate();
        LocalDate endDate = Objects.requireNonNull(DateTimeUtil.convertStringToDateTime(regularPayment.getEndDate())).toLocalDate();

        if (endDate != null) {
            if (endDate.isBefore(now) || endDate.isBefore(nextDate)) {
                throw new InvalidDataFormatException("endDate", regularPayment.getEndDate(), "End date cannot be before current/next date");
            }
        }
        else {
            throw new InvalidDataFormatException(
                    "nextDate",
                    regularPayment.getNextDate(),
                    DateTimeUtil.DATE_TIME_FORMAT);
        }

    }

    private void validateFrequency(RegularPayment regularPayment) {

        if (regularPayment.getFrequency() == null) {
            throw new MissingParameterException("frequency");
        }

        regularPayment.setFrequency(regularPayment.getFrequency().toUpperCase());

        if (!RegularPayment.Frequency.isValid(regularPayment.getFrequency())) {
            throw new InvalidDataFormatException("frequency", regularPayment.getFrequency(), "['DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY']");
        }

    }

    private void validateName(RegularPayment regularPayment) {

        if (regularPayment.getName() == null || regularPayment.getName().isEmpty()) {
            throw new MissingParameterException("name");
        }

        // Stream to extract all regular payments names into a list
        List<String> allUserRegularPaymentName = regularPaymentRepository.findAllByUserId(regularPayment.getUserId()).stream()
                .map(RegularPayment::getName)
                .toList();

        // User cannot have more than 1 regular payment of the same name
        if (allUserRegularPaymentName.contains(regularPayment.getName())) {
            throw new ResourceAlreadyExistsException(RegularPayment.class, "name", regularPayment.getName());
        }

    }

    private void sendRegularPaymentsAdminUpdate() {
        AdminEvent adminEvent = new AdminEvent(AdminEvent.EventType.REGULAR_PAYMENTS_UPDATED);
        webSocketService.sendAdminUpdate(adminEvent);
    }


}

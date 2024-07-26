package com.finbro.FinBroJavaSpring.exception;

import com.finbro.FinBroJavaSpring.exception.accountexceptions.AccountIDNotFoundException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NegativeBalanceException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NotesTooLongException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.UnderMinimumBalanceException;
import com.finbro.FinBroJavaSpring.exception.userexceptions.*;
import com.finbro.FinBroJavaSpring.service.AccountService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;



@RestControllerAdvice
public class RestExceptionHandler {

    public enum ErrorCode {
        USERNAME_ALREADY_EXISTS("USERNAME_ALREADY_EXISTS", "Username already exists."),
        USER_ID_NOT_FOUND("USER_ID_NOT_FOUND", "User ID not found."),
        USERNAME_NOT_FOUND("USERNAME_NOT_FOUND", "Username not found."),
        EMAIL_ALREADY_EXISTS("EMAIL_ALREADY_EXISTS", "Email already exists."),
        EMAIL_NOT_FOUND("EMAIL_NOT_FOUND", "Email not found."),
        INVALID_EMAIL_FORMAT("INVALID_EMAIL_FORMAT", "Invalid email format."),
        MISSING_PARAMETER("MISSING_PARAMETER", "Missing parameter."),
        INCORRECT_PASSWORD("INCORRECT_PASSWORD", "Incorrect password."),
        BALANCE_BELOW_ZERO("BALANCE_BELOW_ZERO", "Balance below 0"),
        BALANCE_BELOW_MINIMUM("BALANCE_BELOW_MINIMUM", "Balance is below minimum balance"),
        NOTES_TOO_LONG("NOTES_TOO_LONG", "Notes exceed maximum characters"),
        INVALID_DATE_FORMAT("INVALID_DATE_FORMAT", "Invalid date format"),
        ACCOUNT_ID_NOT_FOUND("ACCOUNT_ID_NOT_FOUND", "Account ID not found");

        private final String code;
        private final String description;

        ErrorCode(String code, String description) {
            this.code = code;
            this.description = description;
        }

        public String getCode() {
            return code;
        }

        public String getDescription() {
            return description;
        }
    }

    @ExceptionHandler(MissingParameterException.class)
    public ResponseEntity<ErrorResponse> exceptionMissingParameter(MissingParameterException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.BAD_REQUEST.value(),
                ErrorCode.MISSING_PARAMETER.getCode(),
                "Missing parameter: " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(errorResponse);

    }



    // USER SPECIFIC

    @ExceptionHandler(UsernameAlreadyExistsException.class)
    public ResponseEntity<ErrorResponse> exceptionUsernameAlreadyExists(UsernameAlreadyExistsException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.CONFLICT.value(),
                ErrorCode.USERNAME_ALREADY_EXISTS.getCode(),
                "Username already exists: " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.CONFLICT)
                .body(errorResponse);

    }

    @ExceptionHandler(UserIDNotFoundException.class)
    public ResponseEntity<ErrorResponse> exceptionUserIDNotFound(UserIDNotFoundException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.NOT_FOUND.value(),
                ErrorCode.USER_ID_NOT_FOUND.getCode(),
                "User ID not found: " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(errorResponse);

    }

    @ExceptionHandler(UsernameNotFoundException.class)
    public ResponseEntity<ErrorResponse> exceptionUsernameNotFound(UsernameNotFoundException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.NOT_FOUND.value(),
                ErrorCode.USERNAME_NOT_FOUND.getCode(),
                "Username not found: " + e.getMessage(),
                LocalDateTime.now());

        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(errorResponse);

    }

    @ExceptionHandler(EmailNotFoundException.class)
    public ResponseEntity<ErrorResponse> exceptionEmailNotFound(EmailNotFoundException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.NOT_FOUND.value(),
                ErrorCode.EMAIL_NOT_FOUND.getCode(),
                "Email not found: " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(errorResponse);

    }

    @ExceptionHandler(EmailAlreadyExistsException.class)
    public ResponseEntity<ErrorResponse> exceptionEmailAlreadyExists(EmailAlreadyExistsException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.CONFLICT.value(),
                ErrorCode.EMAIL_ALREADY_EXISTS.getCode(),
                "Email already exists: " + e.getMessage(),
                LocalDateTime.now());

        return ResponseEntity
                .status(HttpStatus.CONFLICT)
                .body(errorResponse);

    }

    @ExceptionHandler(InvalidEmailFormatException.class)
    public ResponseEntity<ErrorResponse> exceptionInvalidEmailFormat(InvalidEmailFormatException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.BAD_REQUEST.value(),
                ErrorCode.INVALID_EMAIL_FORMAT.getCode(),
                "Invalid email format: " + e.getMessage(),
                LocalDateTime.now());

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(errorResponse);

    }

    @ExceptionHandler(IncorrectPasswordException.class)
    public ResponseEntity<ErrorResponse> exceptionIncorrectPassword(IncorrectPasswordException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.UNAUTHORIZED.value(),
                ErrorCode.INCORRECT_PASSWORD.getCode(),
                "Incorrect password for Email : " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.UNAUTHORIZED)
                .body(errorResponse);
    }


    // ACCOUNT SPECIFIC

    @ExceptionHandler(NegativeBalanceException.class)
    public ResponseEntity<ErrorResponse> exceptionNegativeBalance(NegativeBalanceException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.BAD_REQUEST.value(),
                ErrorCode.BALANCE_BELOW_ZERO.getCode(),
                "Balance cannot be below 0: " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(errorResponse);

    }

    @ExceptionHandler(UnderMinimumBalanceException.class)
    public ResponseEntity<ErrorResponse> exceptionUnderMinimumBalance(UnderMinimumBalanceException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.BAD_REQUEST.value(),
                ErrorCode.BALANCE_BELOW_MINIMUM.getCode(),
                "Balance cannot be below the minimum balance: " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(errorResponse);

    }

    @ExceptionHandler(NotesTooLongException.class)
    public ResponseEntity<ErrorResponse> exceptionNoteTooLong(NotesTooLongException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.BAD_REQUEST.value(),
                ErrorCode.NOTES_TOO_LONG.getCode(),
                "Notes cannot be longer than " + AccountService.MAX_NOTES_LENGTH + " characters: " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(errorResponse);

    }

    @ExceptionHandler(AccountIDNotFoundException.class)
    public ResponseEntity<ErrorResponse> exceptionAccountIDNotFound(AccountIDNotFoundException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.NOT_FOUND.value(),
                ErrorCode.ACCOUNT_ID_NOT_FOUND.getCode(),
                "Account ID was not found: " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(errorResponse);

    }

    @ExceptionHandler(InvalidDateFormatException.class)
    public ResponseEntity<ErrorResponse> exceptionInvalidDateFormatException(InvalidDateFormatException e) {

        ErrorResponse errorResponse = new ErrorResponse(
                HttpStatus.BAD_REQUEST.value(),
                ErrorCode.INVALID_DATE_FORMAT.getCode(),
                "Invalid date format (yyyy-MM-dd HH:mm:ss): " + e.getMessage(),
                LocalDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(errorResponse);

    }


}

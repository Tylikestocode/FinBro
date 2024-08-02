package com.finbro.FinBroJavaSpring.exception;

import com.finbro.FinBroJavaSpring.exception.accountexceptions.AccountIDNotFoundException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NegativeBalanceException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.NotesTooLongException;
import com.finbro.FinBroJavaSpring.exception.accountexceptions.UnderMinimumBalanceException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.InvalidDateFormatException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.MissingParameterException;
import com.finbro.FinBroJavaSpring.exception.userexceptions.*;
import com.finbro.FinBroJavaSpring.service.AccountService;
import com.finbro.FinBroJavaSpring.util.ApiResponseUtil;
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


    // GENERAL

    @ExceptionHandler(MissingParameterException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionMissingParameter(MissingParameterException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.BAD_REQUEST,
                ErrorCode.MISSING_PARAMETER,
                "Missing parameter: " + e.getMessage()
        );

    }



    // USER SPECIFIC

    @ExceptionHandler(UsernameAlreadyExistsException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionUsernameAlreadyExists(UsernameAlreadyExistsException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.CONFLICT,
                ErrorCode.USERNAME_ALREADY_EXISTS,
                "Username already exists: " + e.getMessage()
        );

    }

    @ExceptionHandler(UserIDNotFoundException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionUserIDNotFound(UserIDNotFoundException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.NOT_FOUND,
                ErrorCode.USER_ID_NOT_FOUND,
                "User ID not found: " + e.getMessage()
        );

    }

    @ExceptionHandler(UsernameNotFoundException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionUsernameNotFound(UsernameNotFoundException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.NOT_FOUND,
                ErrorCode.USERNAME_NOT_FOUND,
                "Username not found: " + e.getMessage()
        );

    }

    @ExceptionHandler(EmailNotFoundException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionEmailNotFound(EmailNotFoundException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.NOT_FOUND,
                ErrorCode.EMAIL_NOT_FOUND,
                "Email not found: " + e.getMessage()
        );

    }

    @ExceptionHandler(EmailAlreadyExistsException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionEmailAlreadyExists(EmailAlreadyExistsException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.CONFLICT,
                ErrorCode.USERNAME_ALREADY_EXISTS,
                "Email already exists: " + e.getMessage()
        );

    }

    @ExceptionHandler(InvalidEmailFormatException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionInvalidEmailFormat(InvalidEmailFormatException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.BAD_REQUEST,
                ErrorCode.INVALID_EMAIL_FORMAT,
                "Invalid email format: " + e.getMessage()
        );

    }

    @ExceptionHandler(IncorrectPasswordException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionIncorrectPassword(IncorrectPasswordException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.UNAUTHORIZED,
                ErrorCode.INCORRECT_PASSWORD,
                "Incorrect password for Email: " + e.getMessage()
        );

    }


    // ACCOUNT SPECIFIC

    @ExceptionHandler(NegativeBalanceException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionNegativeBalance(NegativeBalanceException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.BAD_REQUEST,
                ErrorCode.BALANCE_BELOW_ZERO,
                "Balance cannot be below 0: " + e.getMessage()
        );

    }

    @ExceptionHandler(UnderMinimumBalanceException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionUnderMinimumBalance(UnderMinimumBalanceException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.BAD_REQUEST,
                ErrorCode.BALANCE_BELOW_MINIMUM,
                "Balance cannot be below minimum balance: " + e.getMessage()
        );

    }

    @ExceptionHandler(NotesTooLongException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionNoteTooLong(NotesTooLongException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.BAD_REQUEST,
                ErrorCode.NOTES_TOO_LONG,
                "Notes cannot be longer than " + AccountService.MAX_NOTES_LENGTH + " characters: " + e.getMessage()
        );

    }

    @ExceptionHandler(AccountIDNotFoundException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionAccountIDNotFound(AccountIDNotFoundException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.NOT_FOUND,
                ErrorCode.ACCOUNT_ID_NOT_FOUND,
                "Account ID not found: " + e.getMessage()
        );

    }

    @ExceptionHandler(InvalidDateFormatException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionInvalidDateFormatException(InvalidDateFormatException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.BAD_REQUEST,
                ErrorCode.INVALID_DATE_FORMAT,
                "Invalid date format (yyyy-MM-dd HH:mm:ss): " + e.getMessage()
        );

    }


}

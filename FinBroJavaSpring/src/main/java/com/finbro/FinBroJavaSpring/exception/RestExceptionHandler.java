package com.finbro.FinBroJavaSpring.exception;

import com.finbro.FinBroJavaSpring.exception.accountexceptions.*;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.*;
import com.finbro.FinBroJavaSpring.exception.userexceptions.*;
import com.finbro.FinBroJavaSpring.service.AccountService;
import com.finbro.FinBroJavaSpring.util.ApiResponseUtil;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;


@RestControllerAdvice
public class RestExceptionHandler {

    public enum ErrorCode {
        MISSING_PARAMETER("MISSING_PARAMETER", "Missing parameter."),
        RESOURCE_NOT_FOUND("RESOURCE_NOT_FOUND", "Resource with given value cannot be found"),
        RESOURCE_ALREADY_EXISTS("RESOURCE_ALREADY_EXISTS", "Resource with given value already exists"),
        INVALID_DATA_FORMAT("INVALID_DATA_FORMAT", "Data was sent in the incorrect format"),
        INCORRECT_PASSWORD("INCORRECT_PASSWORD", "Incorrect password."),
        BALANCE_BELOW_ZERO("BALANCE_BELOW_ZERO", "Balance below 0"),
        BALANCE_BELOW_MINIMUM("BALANCE_BELOW_MINIMUM", "Balance is below minimum balance"),
        NOTES_TOO_LONG("NOTES_TOO_LONG", "Notes exceed maximum characters");

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

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionResourceNotFound(ResourceNotFoundException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.BAD_REQUEST,
                ErrorCode.RESOURCE_NOT_FOUND,
                e.getMessage()
        );

    }

    @ExceptionHandler(ResourceAlreadyExistsException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionResourceAlreadyExists(ResourceAlreadyExistsException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.CONFLICT,
                ErrorCode.RESOURCE_ALREADY_EXISTS,
                e.getMessage()
        );

    }

    @ExceptionHandler(InvalidDataFormatException.class)
    public ResponseEntity<ApiResponse<ErrorResponse>> exceptionInvalidDataFormat(InvalidDataFormatException e) {

        return ApiResponseUtil.createErrorResponse(
                HttpStatus.BAD_REQUEST,
                ErrorCode.INVALID_DATA_FORMAT,
                e.getMessage()
        );

    }



    // USER SPECIFIC

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


}

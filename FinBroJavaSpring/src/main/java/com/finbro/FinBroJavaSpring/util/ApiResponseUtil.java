package com.finbro.FinBroJavaSpring.util;

import com.finbro.FinBroJavaSpring.exception.ApiResponse;
import com.finbro.FinBroJavaSpring.exception.ErrorResponse;
import com.finbro.FinBroJavaSpring.exception.RestExceptionHandler;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.time.LocalDateTime;

public class ApiResponseUtil {

    public static ResponseEntity<ApiResponse<ErrorResponse>> createErrorResponse(
            HttpStatus status, RestExceptionHandler.ErrorCode errorCode, String message) {

        ErrorResponse errorResponse = new ErrorResponse(
                status.value(),
                errorCode.getCode(),
                message,
                LocalDateTime.now());

        return ResponseEntity
                .status(status)
                .body(new ApiResponse<>(false, errorResponse));

    }

}

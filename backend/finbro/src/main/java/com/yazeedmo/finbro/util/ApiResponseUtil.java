package com.yazeedmo.finbro.util;

import com.yazeedmo.finbro.exception.ApiResponse;
import com.yazeedmo.finbro.exception.ErrorResponse;
import com.yazeedmo.finbro.exception.RestExceptionHandler;
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

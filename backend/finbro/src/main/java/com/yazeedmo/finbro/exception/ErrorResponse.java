package com.yazeedmo.finbro.exception;

import java.time.LocalDateTime;

public class ErrorResponse {

    private int status;
    private String errorCode;
    private String details;
    private LocalDateTime timestamp;

    public ErrorResponse(int status, String errorCode, String details, LocalDateTime timestamp) {
        this.status = status;
        this.errorCode = errorCode;
        this.details = details;
        this.timestamp = timestamp;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }
}

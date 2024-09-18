package com.yazeedmo.finbro.exception;

public class ApiResponse<T> {

    private boolean success;
    private T data;
    private ErrorResponse error;

    public ApiResponse(boolean success, T data) {
        this.success = success;
        this.data = data;
        this.error = null;
    }

    public ApiResponse(boolean success, ErrorResponse error) {
        this.success = success;
        this.error = error;
        this.data = null;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public ErrorResponse getError() {
        return error;
    }

    public void setError(ErrorResponse error) {
        this.error = error;
    }
}

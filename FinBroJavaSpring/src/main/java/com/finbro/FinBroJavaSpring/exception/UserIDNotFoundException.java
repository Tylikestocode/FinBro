package com.finbro.FinBroJavaSpring.exception;

public class UserIDNotFoundException extends RuntimeException {

    public UserIDNotFoundException(String message) {
        super(message);
    }

}

package com.finbro.FinBroJavaSpring.exception.userexceptions;

public class UserIDNotFoundException extends RuntimeException {

    public UserIDNotFoundException(String message) {
        super(message);
    }

}

package com.finbro.FinBroJavaSpring.exception.userexceptions;

public class EmailNotFoundException extends RuntimeException {

    public EmailNotFoundException(String message) {
        super(message);
    }

}

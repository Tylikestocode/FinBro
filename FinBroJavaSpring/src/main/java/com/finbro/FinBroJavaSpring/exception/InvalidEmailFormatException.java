package com.finbro.FinBroJavaSpring.exception;

public class InvalidEmailFormatException extends RuntimeException {

    public InvalidEmailFormatException(String message) {
        super(message);
    }

}

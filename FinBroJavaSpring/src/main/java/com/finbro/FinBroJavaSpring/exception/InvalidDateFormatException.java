package com.finbro.FinBroJavaSpring.exception;

public class InvalidDateFormatException extends RuntimeException {

    public InvalidDateFormatException(String invalidDate) {
        super(invalidDate);
    }

}

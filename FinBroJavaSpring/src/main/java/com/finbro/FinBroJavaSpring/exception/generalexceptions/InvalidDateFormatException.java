package com.finbro.FinBroJavaSpring.exception.generalexceptions;

public class InvalidDateFormatException extends RuntimeException {

    public InvalidDateFormatException(String invalidDate) {
        super(invalidDate);
    }

}

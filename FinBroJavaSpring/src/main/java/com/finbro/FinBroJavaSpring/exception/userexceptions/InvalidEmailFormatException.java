package com.finbro.FinBroJavaSpring.exception.userexceptions;

public class InvalidEmailFormatException extends RuntimeException {

    public InvalidEmailFormatException(String message) {
        super(message);
    }

}

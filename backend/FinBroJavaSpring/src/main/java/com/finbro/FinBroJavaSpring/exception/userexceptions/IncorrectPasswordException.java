package com.finbro.FinBroJavaSpring.exception.userexceptions;

public class IncorrectPasswordException extends RuntimeException {

    public IncorrectPasswordException(String message) {
        super(message);
    }

}

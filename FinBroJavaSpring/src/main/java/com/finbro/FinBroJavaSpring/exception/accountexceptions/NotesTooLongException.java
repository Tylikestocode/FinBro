package com.finbro.FinBroJavaSpring.exception.accountexceptions;

public class NotesTooLongException extends RuntimeException {

    public NotesTooLongException(String message) {
        super(message);
    }

}

package com.finbro.FinBroJavaSpring.exception.generalexceptions;

public class MissingParameterException extends RuntimeException {

    public MissingParameterException(String message) {
        super(message);
    }

}
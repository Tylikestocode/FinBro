package com.finbro.FinBroJavaSpring.exception.generalexceptions;

public class ServerErrorException extends RuntimeException {

    public ServerErrorException(String message) {
        super(message);
    }

}

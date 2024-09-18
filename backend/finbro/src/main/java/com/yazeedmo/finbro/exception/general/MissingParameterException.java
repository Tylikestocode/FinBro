package com.yazeedmo.finbro.exception.general;

public class MissingParameterException extends RuntimeException {

    public MissingParameterException(String parameterName) {
        super(parameterName);
    }

}

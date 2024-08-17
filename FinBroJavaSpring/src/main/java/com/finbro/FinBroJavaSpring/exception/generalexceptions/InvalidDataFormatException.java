package com.finbro.FinBroJavaSpring.exception.generalexceptions;

public class InvalidDataFormatException extends RuntimeException {

    public InvalidDataFormatException(String fieldName, String data, String expectedFormat) {
        super(String.format(
                "Invalid %s format: %s | Expected format: %s",
                fieldName, data, expectedFormat));
    }

}

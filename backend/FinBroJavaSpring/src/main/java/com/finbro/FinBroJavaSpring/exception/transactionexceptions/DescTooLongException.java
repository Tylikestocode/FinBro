package com.finbro.FinBroJavaSpring.exception.transactionexceptions;

public class DescTooLongException extends RuntimeException {

    public DescTooLongException(String descLength) {
        super(descLength);
    }

}

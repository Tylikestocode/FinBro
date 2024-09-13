package com.finbro.FinBroJavaSpring.exception.accountexceptions;

public class UnderMinimumBalanceException extends RuntimeException {

    public UnderMinimumBalanceException(String balance) {
        super(balance);
    }

}

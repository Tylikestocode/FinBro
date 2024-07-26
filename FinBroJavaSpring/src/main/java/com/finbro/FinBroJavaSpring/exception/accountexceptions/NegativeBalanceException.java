package com.finbro.FinBroJavaSpring.exception.accountexceptions;

public class NegativeBalanceException extends RuntimeException {

    public NegativeBalanceException(String amount) {
        super(amount);
    }

}

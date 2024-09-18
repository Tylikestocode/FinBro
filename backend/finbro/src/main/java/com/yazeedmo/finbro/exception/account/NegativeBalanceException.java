package com.yazeedmo.finbro.exception.account;

public class NegativeBalanceException extends RuntimeException {

    public NegativeBalanceException(String amount) {
        super(amount);
    }

}

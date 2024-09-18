package com.yazeedmo.finbro.exception.account;

public class UnderMinimumBalanceException extends RuntimeException {

    public UnderMinimumBalanceException(String balance) {
        super(balance);
    }

}

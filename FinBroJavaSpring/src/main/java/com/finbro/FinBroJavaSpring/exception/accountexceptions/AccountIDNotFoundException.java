package com.finbro.FinBroJavaSpring.exception.accountexceptions;

public class AccountIDNotFoundException extends RuntimeException {

    public AccountIDNotFoundException(String accountId) {
        super(accountId);
    }

}

package com.finbro.FinBroJavaSpring.exception.userexceptions;

public class UsernameNotFoundException extends RuntimeException {

    public UsernameNotFoundException(String message) {
        super(message);
    }

}

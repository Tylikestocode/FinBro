package com.yazeedmo.finbro.exception.account;

public class NotesTooLongException extends RuntimeException {

    public NotesTooLongException(String notesLength) {
        super(notesLength);
    }

}

package com.yazeedmo.finbro.exception.transaction;

public class DescTooLongException extends RuntimeException {

    public DescTooLongException(String descLength) {
        super(descLength);
    }

}

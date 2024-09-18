package com.yazeedmo.finbro.exception.general;

public class ResourceAlreadyExistsException extends RuntimeException {

    public ResourceAlreadyExistsException(Class<?> clazz, String fieldName, String data) {
        super(String.format("%s with %s '%s' already exists",
                clazz.getSimpleName(), fieldName, data));
    }

}

package com.finbro.FinBroJavaSpring.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDateTime;

public class Test {

    @JsonFormat(pattern = "yyyy-mmm-dd HH:mm")
    private LocalDateTime now = LocalDateTime.now();

    public LocalDateTime getNow() {
        return now;
    }

    public void setNow(LocalDateTime now) {
        this.now = now;
    }
}

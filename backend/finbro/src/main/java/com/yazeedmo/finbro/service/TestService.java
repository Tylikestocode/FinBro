package com.yazeedmo.finbro.service;

import com.yazeedmo.finbro.domain.Test;
import com.yazeedmo.finbro.util.DateTimeUtil;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class TestService {

    public String getNow() {
        Test test = new Test();
        LocalDateTime now = test.getNow();
        return DateTimeUtil.convertDateTimeToString(now);
    }

}

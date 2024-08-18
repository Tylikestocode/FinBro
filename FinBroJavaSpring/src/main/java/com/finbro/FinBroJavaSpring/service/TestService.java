package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.Test;
import com.finbro.FinBroJavaSpring.util.DateTimeUtil;
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

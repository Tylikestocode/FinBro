package com.yazeedmo.finbro.controller;

import com.yazeedmo.finbro.exception.ApiResponse;
import com.yazeedmo.finbro.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/test")
public class TestController {

    private final TestService testService;

    @Autowired
    public TestController(TestService testService) {
        this.testService = testService;
    }

    @GetMapping
    public ResponseEntity<?> getNowDate() {

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, testService.getNow()));

    }

}

package com.yazeedmo.finbro.controller.admin;

import com.yazeedmo.finbro.domain.ApiResponse;
import com.yazeedmo.finbro.domain.RegularPayment;
import com.yazeedmo.finbro.service.RegularPaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admin/regular-payments")
@CrossOrigin(origins = "http://localhost")
public class AdminRegularPaymentController {

    private final RegularPaymentService regularPaymentService;

    @Autowired
    public AdminRegularPaymentController(RegularPaymentService regularPaymentService) {
        this.regularPaymentService = regularPaymentService;
    }



    @GetMapping()
    public ResponseEntity<ApiResponse<List<RegularPayment>>> getRegularPayments() {

        List<RegularPayment> allRegularPayments = regularPaymentService.getAllRegularPayments();

        ApiResponse<List<RegularPayment>> apiResponse = new ApiResponse<>(true, allRegularPayments);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

}

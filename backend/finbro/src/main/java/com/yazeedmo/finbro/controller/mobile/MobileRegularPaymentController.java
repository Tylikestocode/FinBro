package com.yazeedmo.finbro.controller.mobile;

import com.yazeedmo.finbro.domain.RegularPayment;
import com.yazeedmo.finbro.domain.ApiResponse;
import com.yazeedmo.finbro.service.RegularPaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/mobile/regular-payments")
@CrossOrigin(origins = "http://localhost")
public class MobileRegularPaymentController {

    private final RegularPaymentService regularPaymentService;

    @Autowired
    public MobileRegularPaymentController(RegularPaymentService regularPaymentService) {
        this.regularPaymentService = regularPaymentService;
    }



    @PostMapping()
    public ResponseEntity<ApiResponse<RegularPayment>> createCategory(@RequestBody RegularPayment regularPayment) {

        RegularPayment savedRegularPayment = regularPaymentService.createRegularPayment(regularPayment);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, savedRegularPayment));

    }

    @GetMapping("/{regularPaymentId}")
    public ResponseEntity<ApiResponse<RegularPayment>> getByRegularPaymentId(@PathVariable Long regularPaymentId) {

        RegularPayment regularPayment = regularPaymentService.getRegularPaymentById(regularPaymentId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, regularPayment));

    }

    @GetMapping("/userId/{userId}")
    public ResponseEntity<ApiResponse<List<RegularPayment>>> getAllByUserId(@PathVariable Long userId) {

        List<RegularPayment> userRegularPayments = regularPaymentService.getAllByUserId(userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, userRegularPayments));

    }

    @GetMapping("/duePayments")
    public ResponseEntity<ApiResponse<List<RegularPayment>>> getAllDuePayments() {

        List<RegularPayment> allDuePayments = regularPaymentService.getAllDuePayments(LocalDateTime.now());

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, allDuePayments));

    }

    @PutMapping()
    public ResponseEntity<ApiResponse<RegularPayment>> updateRegularPayment(@RequestBody RegularPayment regularPayment) {

        RegularPayment updatedRegularPayment = regularPaymentService.updateRegularPayment(regularPayment);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, updatedRegularPayment));

    }

    @DeleteMapping("/{regularPaymentId}")
    public ResponseEntity<ApiResponse<?>> deleteById(@PathVariable Long regularPaymentId) {

        regularPaymentService.deleteRegularPaymentById(regularPaymentId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, null));

    }

}

package com.yazeedmo.finbro.controller.admin;

import com.yazeedmo.finbro.domain.ApiResponse;
import com.yazeedmo.finbro.domain.Category;
import com.yazeedmo.finbro.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admin/categories")
@CrossOrigin(origins = "http://localhost")
public class AdminCategoryController {

    private final CategoryService categoryService;

    @Autowired
    public AdminCategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }



    @GetMapping()
    public ResponseEntity<ApiResponse<List<Category>>> getCategories() {

        List<Category> allCategories = categoryService.getAllCategories();

        ApiResponse<List<Category>> apiResponse = new ApiResponse<>(true, allCategories);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

}

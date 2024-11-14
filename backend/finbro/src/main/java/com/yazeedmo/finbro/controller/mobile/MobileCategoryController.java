package com.yazeedmo.finbro.controller.mobile;

import com.yazeedmo.finbro.domain.Category;
import com.yazeedmo.finbro.exception.ApiResponse;
import com.yazeedmo.finbro.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/mobile/categories")
@CrossOrigin(origins = "http://localhost")
public class MobileCategoryController {

    private final CategoryService categoryService;

    @Autowired
    public MobileCategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }



    @PostMapping()
    public ResponseEntity<ApiResponse<Category>> createCategory(@RequestBody Category category) {

        Category savedCategory = categoryService.createCategory(category);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, savedCategory));

    }

    @GetMapping("/{categoryId}")
    public ResponseEntity<ApiResponse<Category>> getByCategoryId(@PathVariable Long categoryId) {

        Category category = categoryService.getCategoryById(categoryId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, category));

    }

    @GetMapping("/userDefined")
    public ResponseEntity<ApiResponse<List<Category>>> getAllUserDefinedCategories() {

        List<Category> allUserDefinedCategories = categoryService.getAllUserDefinedCategories();

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, allUserDefinedCategories));

    }

    @GetMapping("/type/{type}")
    public ResponseEntity<ApiResponse<List<Category>>> getAllCategoriesByType(@PathVariable String type) {

        List<Category> allCategoriesByType = categoryService.getAllByType(type);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, allCategoriesByType));

    }

    @GetMapping("/userId/{userId}")
    public ResponseEntity<ApiResponse<List<Category>>> getAllByUserId(@PathVariable Long userId) {

        List<Category> userCategories = categoryService.getAllByUserId(userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, userCategories));

    }

    @PutMapping()
    public ResponseEntity<ApiResponse<Category>> updateCategory(@RequestBody Category category) {

        Category updatedCategory = categoryService.updateCategory(category);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, updatedCategory));

    }

    @DeleteMapping("/{categoryId}")
    public ResponseEntity<ApiResponse<?>> deleteById(@PathVariable Long categoryId) {

        categoryService.deleteCategoryById(categoryId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, null));

    }

}

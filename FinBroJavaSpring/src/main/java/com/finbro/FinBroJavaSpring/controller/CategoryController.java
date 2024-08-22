package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.Category;
import com.finbro.FinBroJavaSpring.exception.ApiResponse;
import com.finbro.FinBroJavaSpring.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/categories")
public class CategoryController {

    private final CategoryService categoryService;

    @Autowired
    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @PostMapping("/addCategory")
    public ResponseEntity<ApiResponse<Category>> addCategory (@RequestBody Category category) {

        Category savedCategory = categoryService.saveCategory(category);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, savedCategory));

    }

    @GetMapping("/allCategories")
    public ResponseEntity<ApiResponse<List<Category>>> getCategories() {

        List<Category> allCategories = categoryService.findAllCategories();

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, allCategories));

    }

    @GetMapping("/allUserDefined")
    public ResponseEntity<ApiResponse<List<Category>>> getAllUserDefinedCategories() {

        List<Category> allUserDefinedCategories = categoryService.findAllUserDefinedCategories();

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, allUserDefinedCategories));

    }

    @GetMapping("/allByType/{type}")
    public ResponseEntity<ApiResponse<List<Category>>> getAllCategoriesByType(@PathVariable String type) {

        List<Category> allCategoriesByType = categoryService.findAllByType(type);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, allCategoriesByType));

    }

    @GetMapping("/getById/{categoryId}")
    public ResponseEntity<ApiResponse<Category>> getByCategoryId(@PathVariable Long categoryId) {

        Category category = categoryService.findByCategoryId(categoryId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, category));

    }

    @GetMapping("/getAllByUserId/{userId}")
    public ResponseEntity<ApiResponse<List<Category>>> getAllByUserId(@PathVariable Long userId) {

        List<Category> userCategories = categoryService.findAllByUserId(userId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, userCategories));

    }

    @PutMapping("/updateCategory")
    public ResponseEntity<ApiResponse<Category>> updateCategory(@RequestBody Category category) {

        Category updatedCategory = categoryService.updateCategory(category);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, updatedCategory));

    }

    @DeleteMapping("/deleteById/{categoryId}")
    public ResponseEntity<ApiResponse<?>> deleteCategory(@PathVariable Long categoryId) {

        categoryService.deleteCategoryById(categoryId);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(new ApiResponse<>(true, null));

    }

}

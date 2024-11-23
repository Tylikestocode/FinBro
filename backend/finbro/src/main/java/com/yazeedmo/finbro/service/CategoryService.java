package com.yazeedmo.finbro.service;

import com.yazeedmo.finbro.domain.AdminEvent;
import com.yazeedmo.finbro.domain.Category;
import com.yazeedmo.finbro.domain.User;
import com.yazeedmo.finbro.exception.general.InvalidDataFormatException;
import com.yazeedmo.finbro.exception.general.MissingParameterException;
import com.yazeedmo.finbro.exception.general.ResourceAlreadyExistsException;
import com.yazeedmo.finbro.exception.general.ResourceNotFoundException;
import com.yazeedmo.finbro.exception.transaction.DescTooLongException;
import com.yazeedmo.finbro.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@SuppressWarnings("BooleanMethodIsAlwaysInverted")
@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    private final UserService userService;

    private final WebSocketService webSocketService;

    public final static int MAX_DESC_LENGTH = 500;

    @Autowired
    public CategoryService(CategoryRepository categoryRepository, UserService userService, WebSocketService webSocketService) {
        this.categoryRepository = categoryRepository;
        this.userService = userService;
        this.webSocketService = webSocketService;
    }



    public Category createCategory(Category category) {

        validateCategory(category, true);

        sendCategoriesAdminUpdate();
        return categoryRepository.save(category);

    }

    public List<Category> getAllCategories() {

        return (List<Category>) categoryRepository.findAll();

    }

    public Category getCategoryById(Long categoryId) {

        if (!categoryRepository.existsById(categoryId)) {
            throw new ResourceNotFoundException(Category.class, "id", String.valueOf(categoryId));
        }

        return categoryRepository.findById(categoryId).orElse(null);

    }

    public boolean existsById(Long categoryId) {
        return categoryRepository.existsById(categoryId);
    }

    public List<Category> getAllUserDefinedCategories() {

        return categoryRepository.findAllByUserDefined(true);

    }

    public List<Category> getAllByType(String type) {

        return categoryRepository.findAllByType(type.toUpperCase());

    }

    public List<Category> getAllByUserId(Long userId) {

        List<Category> userCategories = categoryRepository.findAllByUserId(userId);
        userCategories.addAll(categoryRepository.findAllByUserDefined(false));

        return userCategories;

    }

    public Category updateCategory(Category category) {

        validateCategory(category, false);

        sendCategoriesAdminUpdate();

        return categoryRepository.save(category);

    }

    public void deleteCategoryById(Long id) {

        if (!categoryRepository.existsById(id)) {
            throw new ResourceNotFoundException(Category.class, "id", String.valueOf(id));
        }

        sendCategoriesAdminUpdate();

        categoryRepository.deleteById(id);

    }


    // HELPER METHODS

    // All validation happens in one function
    private void validateCategory(Category category, boolean isNew) {

        // Validation when adding a new Category
        if (isNew) {

            // ID for new Category must be null -> database auto generates new ID's
            if (category.getId() != null) {
                category.setId(null);
            }

            validateUserId(category);

            // Stream to extract all category names into a list
            List<String> allUserCateNames = categoryRepository.findAllByUserId(category.getUserId()).stream()
                    .map(Category::getName)
                    .toList();

            // User cannot have more than 1 category of same name
            if (allUserCateNames.contains(category.getName())) {
                throw new ResourceAlreadyExistsException(Category.class, "name", category.getName());
            }

        }
        else {

            // Category ID must not be null
            if (category.getId() == null) {
                throw new MissingParameterException("id");
            }

            // Category ID must exist in Categories table
            if (!categoryRepository.existsById(category.getId())) {
                throw new ResourceNotFoundException(Category.class, "id", String.valueOf(category.getId()));
            }

            validateName(category);

        }

        // Validation regardless if category is new or not
        validateType(category);
        validateDescription(category);
        trimStringData(category);

    }

    private void validateName(Category category) {

        if (Category.predefinedNames.contains(category.getName())) {
            throw new ResourceAlreadyExistsException(Category.class, "name", category.getName());
        }
        else {
            validateUserId(category);
        }

    }

    private void validateUserId(Category category) {

        if (category.getUserId() == null) {
            throw new MissingParameterException("userId");
        }

        if (!userService.existsById(category.getUserId())) {
            throw new ResourceNotFoundException(User.class, "id", String.valueOf(category.getUserId()));
        }

    }

    private void validateType(Category category) {

        category.setType(category.getType().toUpperCase());

        if (!Category.CategoryType.isValid(category.getType())) {
            throw new InvalidDataFormatException("type", category.getType(), "['ACCOUNT', 'TRANSACTION', 'BUDGET']");
        }

    }

    private void validateDescription(Category category) {

        if (category.getDescription() != null && category.getDescription().length() > MAX_DESC_LENGTH) {
            throw new DescTooLongException(String.valueOf(category.getDescription().length()));
        }

    }

    private void trimStringData(Category category) {

        category.setName(category.getName().trim());
        category.setDescription(category.getDescription().trim());

    }

    private void sendCategoriesAdminUpdate() {
        AdminEvent adminEvent = new AdminEvent(AdminEvent.EventType.CATEGORIES_UPDATED);
        webSocketService.sendAdminUpdate(adminEvent);
    }

}

package com.finbro.FinBroJavaSpring.service;

import com.finbro.FinBroJavaSpring.domain.Category;
import com.finbro.FinBroJavaSpring.domain.User;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.InvalidDataFormatException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.MissingParameterException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.ResourceAlreadyExistsException;
import com.finbro.FinBroJavaSpring.exception.generalexceptions.ResourceNotFoundException;
import com.finbro.FinBroJavaSpring.exception.transactionexceptions.DescTooLongException;
import com.finbro.FinBroJavaSpring.repository.CategoryRepository;
import com.finbro.FinBroJavaSpring.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;

    public final static int MAX_DESC_LENGTH = 500;

    @Autowired
    public CategoryService(CategoryRepository categoryRepository, UserRepository userRepository) {
        this.categoryRepository = categoryRepository;
        this.userRepository = userRepository;
    }



    public Category createCategory(Category category) {

        validateCategory(category, true);

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

        return categoryRepository.save(category);

    }

    public void deleteCategoryById(Long id) {

        if (!categoryRepository.existsById(id)) {
            throw new ResourceNotFoundException(Category.class, "id", String.valueOf(id));
        }

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

            // Stream to extract all names into a list
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

            // Account ID must exist in Categories table
            if (!categoryRepository.existsById(category.getId())) {
                throw new ResourceNotFoundException(Category.class, "id", String.valueOf(category.getId()));
            }

            validateName(category);

        }

        // Validation regardless if category is new or not
        validateType(category);
        validateDescription(category);

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

        if (!userRepository.existsById(category.getUserId())) {
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

    // id, name, description, type, is_user_defined, user_id

}

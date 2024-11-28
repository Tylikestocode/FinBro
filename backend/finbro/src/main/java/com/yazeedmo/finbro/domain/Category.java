package com.yazeedmo.finbro.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import java.util.Arrays;
import java.util.List;

@Table(name = "CATEGORIES")
public class Category {

    public enum CategoryType {
        BUDGET, ACCOUNT, TRANSACTION;

        @Override
        public String toString() {
            return name();
        }

        public static CategoryType fromString(String type) {
            return CategoryType.valueOf(type.toUpperCase());
        }

        public static boolean isValid(String type) {
            if (type == null) {
                return false;
            }
            try {
                CategoryType.valueOf(type.toUpperCase());
                return true;
            }
            catch (IllegalArgumentException e) {
                return false;
            }
        }
    }

    public static final List<String> predefinedNames = Arrays.asList(
            "Savings",
            "Groceries",
            "Investments",
            "Leisure",
            "Health",
            "Home",
            "Cafe",
            "Education",
            "Gifts",
            "Family",
            "Workout",
            "Transportation",
            "Other"
    );

    @Id
    private Long id;
    private String name;
    private String type;
    private String description;
    boolean isUserDefined;
    private Long userId;

    public Category() {}

    public Category(Long id, String name, String type, String description, Long userId) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.description = description;
        this.userId = userId;
    }

    public Category(Long id, String name, String type, String description, boolean isUserDefined, Long userId) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.description = description;
        this.isUserDefined = isUserDefined;
        this.userId = userId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isUserDefined() {
        return isUserDefined;
    }

    public void setUserDefined(boolean userDefined) {
        isUserDefined = userDefined;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", description='" + description + '\'' +
                ", isUserDefined=" + isUserDefined +
                ", userId=" + userId +
                '}';
    }

}

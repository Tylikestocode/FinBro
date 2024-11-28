package com.yazeedmo.finbro.domain.dto;

public class TopCategoryDTO {
    private String categoryName;
    private Long transactionCount;

    // Constructors, getters, and setters
    public TopCategoryDTO(String categoryName, Long transactionCount) {
        this.categoryName = categoryName;
        this.transactionCount = transactionCount;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Long getTransactionCount() {
        return transactionCount;
    }

    public void setTransactionCount(Long transactionCount) {
        this.transactionCount = transactionCount;
    }
}

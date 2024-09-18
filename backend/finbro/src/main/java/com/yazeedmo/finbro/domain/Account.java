package com.yazeedmo.finbro.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import java.math.BigDecimal;

@Table(name = "ACCOUNTS")
public class Account {

    @Id
    private Long id;
    private String name;
    private boolean allowNegativeBalance;
    private BigDecimal minimumBalance;
    private BigDecimal balance;
    private String dateCreated;
    private String notes;
    private Long userId;
    private Long categoryId;

    public Account() {

    }

    public Account(Long id, String name, boolean allowNegativeBalance, BigDecimal minimumBalance, BigDecimal balance, String dateCreated, String notes, Long userId, Long categoryId) {
        this.id = id;
        this.name = name;
        this.allowNegativeBalance = allowNegativeBalance;
        this.minimumBalance = minimumBalance;
        this.balance = balance;
        this.dateCreated = dateCreated;
        this.notes = notes;
        this.userId = userId;
        this.categoryId = categoryId;
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

    public boolean isAllowNegativeBalance() {
        return allowNegativeBalance;
    }

    public void setAllowNegativeBalance(boolean allowNegativeBalance) {
        this.allowNegativeBalance = allowNegativeBalance;
    }

    public BigDecimal getMinimumBalance() {
        return minimumBalance;
    }

    public void setMinimumBalance(BigDecimal minimumBalance) {
        this.minimumBalance = minimumBalance;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public String getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return "Account{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", allowNegativeBalance=" + allowNegativeBalance +
                ", minimumBalance=" + minimumBalance +
                ", balance=" + balance +
                ", dateCreated='" + dateCreated + '\'' +
                ", notes='" + notes + '\'' +
                ", userId=" + userId +
                ", categoryId=" + categoryId +
                '}';
    }
}

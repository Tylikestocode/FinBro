package com.finbro.FinBroJavaSpring.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import java.math.BigDecimal;

@Table(name = "ACCOUNTS")
public class Account {

    @Id
    private Long id;
    private String name;
    private BigDecimal balance;
    private String dateCreated;
    private BigDecimal minimumBalance;
    private String notes;
    private Long userId;
    private Long categoryId;

    public Account(Long id, String name, BigDecimal balance, String dateCreated, BigDecimal minimumBalance, String notes, Long userId, Long categoryId) {
        this.id = id;
        this.name = name;
        this.balance = balance;
        this.dateCreated = dateCreated;
        this.minimumBalance = minimumBalance;
        this.notes = notes;
        this.userId = userId;
        this.categoryId = categoryId;
    }

    public Account() {};

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

    public BigDecimal getMinimumBalance() {
        return minimumBalance;
    }

    public void setMinimumBalance(BigDecimal minimumBalance) {
        this.minimumBalance = minimumBalance;
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
                ", balance=" + balance +
                ", dateCreated=" + dateCreated +
                ", minimumBalance=" + minimumBalance +
                ", notes='" + notes + '\'' +
                ", userId=" + userId +
                ", categoryId=" + categoryId +
                '}';
    }
}

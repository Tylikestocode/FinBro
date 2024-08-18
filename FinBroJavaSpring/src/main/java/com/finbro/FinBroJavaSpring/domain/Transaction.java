package com.finbro.FinBroJavaSpring.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Table(name = "TRANSACTIONS")
public class Transaction {

    @Id
    private Long id;
    private BigDecimal amount;
    private String description;
    private String date;
    private String notes;
    private Long userId;
    private Long accountId;
    private Long categoryId;

    public Transaction() {

    }

    public Transaction(Long id, BigDecimal amount, String description, String date, String notes, Long userId, Long accountId, Long categoryId) {
        this.id = id;
        this.amount = amount;
        this.description = description;
        this.date = date;
        this.notes = notes;
        this.userId = userId;
        this.accountId = accountId;
        this.categoryId = categoryId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
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

    public Long getAccountId() {
        return accountId;
    }

    public void setAccountId(Long accountId) {
        this.accountId = accountId;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return "Transaction{" +
                "id=" + id +
                ", amount=" + amount +
                ", description='" + description + '\'' +
                ", date=" + date +
                ", notes='" + notes + '\'' +
                ", userId=" + userId +
                ", accountId=" + accountId +
                ", categoryId=" + categoryId +
                '}';
    }
}

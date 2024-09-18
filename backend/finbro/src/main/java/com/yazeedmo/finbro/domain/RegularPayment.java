package com.yazeedmo.finbro.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import java.math.BigDecimal;

@Table(name = "REGULAR_PAYMENTS")
public class RegularPayment {

    public enum Frequency {
        DAILY, WEEKLY, MONTHLY, YEARLY;

        @Override
        public String toString() {
            return name();
        }

        public static Frequency fromString(String frequency) {
            return Frequency.valueOf(frequency.toUpperCase());
        }

        public static boolean isValid(String frequency) {
            if (frequency == null) {
                return false;
            }
            try {
                Frequency.valueOf(frequency.toUpperCase());
                return true;
            }
            catch (IllegalArgumentException e) {
                return false;
            }
        }
    }

    @Id
    private Long id;
    private String name;
    private BigDecimal amount;
    private String frequency;
    private String nextDate;
    private String endDate;
    private String notes;
    private Long userId;
    private Long accountId;
    private Long categoryId;

    public RegularPayment() {}

    public RegularPayment(Long id, String name, BigDecimal amount, String frequency, String nextDate, String endDate, String notes, Long userId, Long accountId, Long categoryId) {
        this.id = id;
        this.name = name;
        this.amount = amount;
        this.frequency = frequency;
        this.nextDate = nextDate;
        this.endDate = endDate;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getFrequency() {
        return frequency;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }

    public String getNextDate() {
        return nextDate;
    }

    public void setNextDate(String nextDate) {
        this.nextDate = nextDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
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
        return "RegularPayment{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", amount=" + amount +
                ", frequency='" + frequency + '\'' +
                ", next_occurrence_date='" + nextDate + '\'' +
                ", end_date='" + endDate + '\'' +
                ", notes='" + notes + '\'' +
                ", user_id=" + userId +
                ", account_id=" + accountId +
                ", category_id=" + categoryId +
                '}';
    }
}

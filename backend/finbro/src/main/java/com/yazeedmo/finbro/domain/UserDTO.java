package com.yazeedmo.finbro.domain;

import java.util.List;

public class UserDTO {

    private User user;
    private List<Account> accounts;
    private List<Transaction> transactions;
    private List<Category> categories;
    private List<RegularPayment> regularPayments;

    public UserDTO() {}

    public UserDTO(User user, List<Account> accounts, List<Transaction> transactions, List<Category> categories, List<RegularPayment> regularPayments) {
        this.user = user;
        this.accounts = accounts;
        this.transactions = transactions;
        this.categories = categories;
        this.regularPayments = regularPayments;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Account> getAccounts() {
        return accounts;
    }

    public void setAccounts(List<Account> accounts) {
        this.accounts = accounts;
    }

    public List<Transaction> getTransactions() {
        return transactions;
    }

    public void setTransactions(List<Transaction> transactions) {
        this.transactions = transactions;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public void setCategories(List<Category> categories) {
        this.categories = categories;
    }

    public List<RegularPayment> getRegularPayments() {
        return regularPayments;
    }

    public void setRegularPayments(List<RegularPayment> regularPayments) {
        this.regularPayments = regularPayments;
    }

    @Override
    public String toString() {
        return "UserDTO{" +
                "user=" + user +
                ", accounts=" + accounts +
                ", transactions=" + transactions +
                ", categories=" + categories +
                ", regularPayments=" + regularPayments +
                '}';
    }
}

//package com.finbro.FinBroJavaSpring.repository.archivetests;
//
//import com.finbro.FinBroJavaSpring.domain.Account;
//import com.finbro.FinBroJavaSpring.domain.User;
//import com.finbro.FinBroJavaSpring.repository.AccountRepository;
//import com.finbro.FinBroJavaSpring.util.TimeTools;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.test.context.ActiveProfiles;
//
//import java.math.BigDecimal;
//import java.util.List;
//
//import static org.assertj.core.api.Assertions.assertThat;
//
//@SpringBootTest
//@ActiveProfiles("test")
//public class AccountRepositoryTest {
//
//    @Autowired
//    private AccountRepository accountRepository;
//
//    private User user1;
//    private User user2;
//    private User user3;
//
//    private Account account1 = new Account();
//    private Account account2 = new Account();
//    private Account account3 = new Account();
//
//    @BeforeEach
//    public void setUp() {
//
//        user1 = new User();
//        user1.setName("John");
//        user1.setSurname("Doe");
//        user1.setAge(30);
//        user1.setUsername("john.d");
//        user1.setEmail("john.d@example.com");
//        user1.setPassword("hashed_password4");
//
//        user2 = new User();
//        user2.setName("Alice");
//        user2.setSurname("Johnson");
//        user2.setAge(28);
//        user2.setUsername("alice.j");
//        user2.setEmail("alice.j@example.com");
//        user2.setPassword("hashed_password1");
//
//        user3 = new User();
//        user3.setName("Bob");
//        user3.setSurname("Smith");
//        user3.setAge(35);
//        user3.setUsername("bob.s");
//        user3.setEmail("bob.s@example.com");
//        user3.setPassword("hashed_password2");
//
//
//        accountRepository.deleteAll();
//
//        account1.setName("Alice Savings");
//        account1.setBalance(new BigDecimal("1000.00"));
//        account1.setDateCreated(TimeTools.stringToLocalDateTime("2024-01-01 10:00:00"));
//        account1.setMinimumBalance(new BigDecimal("500.00"));
//        account1.setNotes("Primary savings account");
//        account1.setUserId(1L);
//        account1.setCategoryId(1L);
//
//        account2.setName("Bob Checking");
//        account2.setBalance(new BigDecimal("1500.00"));
//        account2.setDateCreated(TimeTools.stringToLocalDateTime("2024-02-01 12:00:00"));
//        account2.setMinimumBalance(null);
//        account2.setNotes("Main checking account");
//        account2.setUserId(2L);
//        account2.setCategoryId(null);
//
//        account3.setName("Emily Investment");
//        account3.setBalance(new BigDecimal("2000.00"));
//        account3.setDateCreated(TimeTools.stringToLocalDateTime("2024-03-01 14:00:00"));
//        account3.setMinimumBalance(new BigDecimal("1000.00"));
//        account3.setName("Long-term investment account");
//        account3.setUserId(3L);
//        account3.setCategoryId(4L);
//    }
//
//
//    @Test
//    public void AccountRepository_Save_ReturnSavedAccount() {
//
//        Account account = accountRepository.save(account1);
//
//        assertThat(account).isNotNull();
//        assertThat(account.getName()).isEqualTo("Alice Savings");
//
//    }
//
//    @Test
//    public void AccountRepository_FindAll_ReturnsAll() {
//
//        accountRepository.save(account1);
//        accountRepository.save(account2);
//        accountRepository.save(account3);
//
//        List<Account> allAccounts = (List<Account>) accountRepository.findAll();
//
//        assertThat(allAccounts).isNotNull();
//        assertThat(allAccounts.size()).isEqualTo(3);
//
//    }
//
//    @Test
//    public void AccountRepository_FindById_ReturnsAccountByID() {
//
//        accountRepository.saveAll(List.of(account1, account2, account3));
//
//        Account getAccount1 = accountRepository.findById(account1.getId()).orElse(null);
//        Account getAccount2 = accountRepository.findById(account2.getId()).orElse(null);
//        Account getAccount3 = accountRepository.findById(account3.getId()).orElse(null);
//        Account getAccount4 = accountRepository.findById(13L).orElse(null);
//
//        assertThat(getAccount1).isNotNull();
//        assertThat(getAccount2).isNotNull();
//        assertThat(getAccount3).isNotNull();
//        assertThat(getAccount4).isNull();
//
//        assertThat(getAccount1.getId()).isEqualTo(account1.getId());
//        assertThat(getAccount2.getName()).isEqualTo("Bob Checking");
//        assertThat(getAccount3.getBalance()).isEqualTo("2000.00");
//
//    }
//
//    @Test
//    public void AccountRepository_FindAllByUserId_ReturnsAllAccountsByUserId() {
//
//        Account newAccount = new Account();
//        newAccount.setName("Alice other account");
//        newAccount.setBalance(new BigDecimal("1000.00"));
//        newAccount.setDateCreated(TimeTools.stringToLocalDateTime("2024-01-01 10:00:00"));
//        newAccount.setMinimumBalance(new BigDecimal("500.00"));
//        newAccount.setNotes("Second savings account");
//        newAccount.setUserId(1L);
//        newAccount.setCategoryId(1L);
//
//        accountRepository.save(account1);
//        accountRepository.save(account2);
//        accountRepository.save(account3);
//        accountRepository.save(newAccount);
//
//        List<Account> allAliceAccounts = accountRepository.findAllByUserId(1L);
//
//        assertThat(allAliceAccounts.size()).isEqualTo(2);
//        assertThat(allAliceAccounts.get(1).getName()).isEqualTo("Alice other account");
//
//    }
//
//    @Test
//    public void AccountRepository_Update_ReturnsUpdatedAccount() {
//
//        Account savedAccount = accountRepository.save(account1);
//
//        savedAccount.setName("New Name");
//        savedAccount.setBalance(new BigDecimal("1234.00"));
//        savedAccount.setDateCreated(TimeTools.stringToLocalDateTime("2024-01-01 10:00:00"));
//        savedAccount.setMinimumBalance(null);
//        savedAccount.setNotes("My New Account");
//        savedAccount.setUserId(1L);
//        savedAccount.setCategoryId(1L);
//
//        Account updatedAccount = accountRepository.save(savedAccount);
//
//        List<Account> allAccounts = (List<Account>) accountRepository.findAll();
//
//        assertThat(allAccounts.size()).isEqualTo(1);
//        assertThat(updatedAccount.getName()).isEqualTo("New Name");
//        assertThat(updatedAccount.getBalance()).isEqualTo(new BigDecimal("1234.00"));
//        assertThat(updatedAccount.getMinimumBalance()).isNull();
//        assertThat(updatedAccount.getNotes()).isEqualTo("My New Account");
//
//    }
//
//    @Test
//    public void AccountRepository_Delete_DeleteAccount() {
//
//        Account savedAccount1 = accountRepository.save(account1);
//        Account savedAccount2 = accountRepository.save(account2);
//        Account savedAccount3 = accountRepository.save(account3);
//
//        accountRepository.deleteById(savedAccount1.getId());
//        List<Account> allAccounts = (List<Account>) accountRepository.findAll();
//        assertThat(allAccounts.size()).isEqualTo(2);
//
//        accountRepository.delete(savedAccount2);
//        savedAccount2 = accountRepository.findById(savedAccount2.getId()).orElse(null);
//        assertThat(savedAccount2).isNull();
//
//
//        accountRepository.deleteAll();
//        allAccounts = (List<Account>) accountRepository.findAll();
//        assertThat(allAccounts.size()).isEqualTo(0);
//
//    }
//
//}

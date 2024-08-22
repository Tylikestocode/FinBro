INSERT INTO Users (name, surname, age, username, email, password)
VALUES ('Alice', 'Johnson', 28, 'alice.j', 'alice.j@example.com', 'hashed_password1'),
       ('Bob', 'Smith', 35, 'bob.s', 'bob.s@example.com', 'hashed_password2'),
       ('Emily', 'Brown', 24, 'emily.b', 'emily.b@example.com', 'hashed_password3'),
	   ('David', 'White', 30, 'david.w', 'david.w@example.com', 'hashed_password4'),
       ('Grace', 'Black', 22, 'grace.b', 'grace.b@example.com', 'hashed_password5');

INSERT INTO Categories (name, type, description, is_user_defined, user_id)
VALUES ('Savings Account', 'ACCOUNT', 'User savings account category', 0, NULL),
	   ('Groceries', 'TRANSACTION', 'Category for grocery expenses', 0, NULL),
       ('Investments', 'ACCOUNT', 'Category for investment accounts', 0, NULL),
       ('Entertainment', 'TRANSACTION', 'Category for entertainment expenses', 0, NULL),
       ('Alice Custom Category', 'TRANSACTION', 'Custom category created by Alice', 1, 1),
       ('Bob Customer Category', 'BUDGET', 'Custom category created by Bob', 1, 2);

INSERT INTO Accounts (name, balance, date_created, minimum_balance, notes, user_id, category_id)
VALUES ('Alice Savings', 1000.00, '2024-01-01 10:00:00', 500.00, 'Primary savings account', 1, 1),
	   ('Bob Checking', 1500.00, '2023-02-01 12:00:00', NULL, 'Main checking account', 2, NULL),
       ('Emily Investment', 2000.00, '2023-03-01 14:00:00', 1000.00, 'Long-term investment account', 3, 4),
       ('David Savings', 2500.00, '2023-04-01 16:00:00', 100.00, 'Secondary savings account', 4, 1),
       ('Grace Budget Account', 300.00, '2023-05-01 18:00:00', NULL, 'Budget management account', 5, 3);

INSERT INTO Transactions (amount, description, date, notes, user_id, account_id, category_id)
VALUES (50.00, 'Grocery shopping', '2023-06-01 10:30:00', 'Bought groceries at SuperMart', 1, 1, 2),
       (20.00, 'Movie tickets', '2023-06-02 11:00:00', 'Watched a movie', 2, 2, 5),
       (100.00, 'Investment deposit', '2023-06-03 12:30:00', 'Monthly investment', 3, 3, 4),
       (30.00, 'Savings deposit', '2023-06-04 14:00:00', 'Added to savings', 4, 4, 1),
       (25.00, 'Dining out', '2023-06-05 15:30:00', 'Dinner at a restaurant', 5, 5, 5);

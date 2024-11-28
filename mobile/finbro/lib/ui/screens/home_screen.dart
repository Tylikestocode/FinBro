import 'package:finbro/api/api_result.dart';
import 'package:finbro/domain/account.dart';
import 'package:finbro/domain/category.dart';
import 'package:finbro/domain/transaction.dart';
import 'package:finbro/service/account_service.dart';
import 'package:finbro/service/category_service.dart';
import 'package:finbro/service/shared_prefs_service.dart';
import 'package:finbro/service/transaction_service.dart';
import 'package:finbro/ui/components/custom_drawer.dart';
import 'package:finbro/ui/components/data_components.dart';
import 'package:finbro/ui/components/ui_colors.dart';
import 'package:finbro/ui/screens/ai_chat.dart';
import 'package:finbro/ui/transactions/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final _sharedPrefsService = SharedPrefsService();
  final _accountsService = AccountService();
  final _transactionService = TransactionService();
  final _categoryService = CategoryService();

  Account? selectedAccount; // Track the selected Account object
  List<Account> allAccounts = []; // Store accounts from the database
  double displayedBalance = 0.0; // Store the balance of the selected account
  List<Transaction> allTransactions = [];
  List<Category> allCategories = [];

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  Future<void> loadAccounts() async {
    int? currentUserId = await _sharedPrefsService.getCurrentUserId();
    ApiResult result = await _accountsService.getAllByUserId(currentUserId!);

    if (result.success) {
      setState(() {
        allAccounts = result.data; // Refresh the account list

        if (selectedAccount != null) {
          // Try to retain the same selected account
          selectedAccount = allAccounts.firstWhere(
            (account) => account.id == selectedAccount!.id,
            orElse: () => allAccounts.isNotEmpty
                ? allAccounts[0]
                : allAccounts[0], // Always return an Account
          );
        } else if (allAccounts.isNotEmpty) {
          // Default to the first account if no account was previously selected
          selectedAccount = allAccounts[0];
        }

        // Update displayed balance based on the retained or new selection
        displayedBalance = selectedAccount?.balance ?? 0.0;
      });

      await fetchTransactionsForSelectedAccount();
    }
  }

  // Placeholder function for fetching transactions
  Future<void> fetchTransactionsForSelectedAccount() async {
    if (selectedAccount != null) {
      ApiResult result =
          await _transactionService.getAllByAccountId(selectedAccount!.id!);

      if (result.success) {
        allTransactions = result.data;
      }

      result = await _categoryService.getAllPredefinedCategories();

      if (result.success) {
        allCategories = result.data;
      }

      setState(() {
        displayedBalance = selectedAccount?.balance ?? 0.0;
      });

      for (Transaction transaction in allTransactions) {
        print(transaction.description);
        print(transaction.date);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Color.fromRGBO(0, 12, 42, 1),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_balance_wallet,
                color: Color.fromRGBO(0, 12, 42, 1)),
            const SizedBox(width: 8),
            DropdownButton<Account>(
              value: selectedAccount,
              icon: const Icon(Icons.arrow_drop_down,
                  color: Color.fromRGBO(0, 12, 42, 1)),
              onChanged: (Account? newAccount) {
                if (newAccount != null) {
                  setState(() {
                    selectedAccount = newAccount; // Update the selected account
                  });

                  fetchTransactionsForSelectedAccount(); // Fetch the transactions for the selected account
                }
              },
              items:
                  allAccounts.map<DropdownMenuItem<Account>>((Account account) {
                return DropdownMenuItem<Account>(
                  value: account,
                  child: Text(
                    account.name,
                    style: TextStyle(color: Color.fromRGBO(0, 12, 42, 1),
                    fontSize: 20.0),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 12, 42, 1),
              Color.fromRGBO(35, 61, 128, 1),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            // Balance Display
            Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.15),
              child: BalanceCard(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                balance: displayedBalance, // Pass the current balance
              ),
            ),
            // Feature Buttons
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth * 0.025, bottom: screenWidth * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenWidth * 0.15,
                      top: screenWidth * 0.08,
                      bottom: screenWidth * 0.08,
                    ),
                    child: NewTransactionButton(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      selectedAccount: selectedAccount,
                      onTransactionAdded: () async {
                        await loadAccounts(); // Reload accounts when the transaction is added
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenWidth * 0.08,
                      bottom: screenWidth * 0.08,
                    ),
                    child: FinBroButton(
                        screenWidth: screenWidth, screenHeight: screenHeight),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.15,
                      top: screenWidth * 0.08,
                      bottom: screenWidth * 0.08,
                    ),
                    child: BudgetBroButton(
                        screenWidth: screenWidth, screenHeight: screenHeight),
                  ),
                ],
              ),
            ),
            // Placeholder for Recent Transactions
            Expanded(
              child: RecentTransactionsListView(
                  transactions: allTransactions,
                  categories: allCategories,
                  screenWidth: screenWidth,
                  screenHeight: screenHeight),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final double balance; // Add balance as a parameter

  const BalanceCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.balance, // Initialize the balance
  });

  @override
  State<BalanceCard> createState() => _BalanceCard();
}

class _BalanceCard extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: widget.screenWidth * 0.01),
        child: Text(
          'Balance',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: widget.screenWidth * 0.03,
          ),
        ),
      ),
      Text(
        'R ${widget.balance.toStringAsFixed(2)}', // Display the balance dynamically
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: widget.screenWidth * 0.1,
        ),
      ),
    ]);
  }
}

class NewTransactionButton extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Account? selectedAccount;
  final Future<void> Function() onTransactionAdded; // Callback function

  const NewTransactionButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.selectedAccount,
    required this.onTransactionAdded, // Pass the callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Navigate to AddTransactionScreen and await the result
        bool? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AddTransactionScreen(selectedAccount: selectedAccount!),
          ),
        );

        // Check the result and trigger callback if the transaction was added
        if (result == true) {
          await onTransactionAdded(); // Run the callback function
        }
      },
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(148, 171, 229, 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/square-plus-solid.svg',
                width: 36,
                height: 36,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenWidth * 0.03),
            child: Center(
              child: Text(
                'Add',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.025,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FinBroButton extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const FinBroButton(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<FinBroButton> createState() => _FinBroButton();
}

class _FinBroButton extends State<FinBroButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AiChat()));
      },
      child: Column(
        children: [
          Container(
            width: widget.screenWidth * 0.15,
            height: widget.screenWidth * 0.15,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(148, 171, 229, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: SvgPicture.asset('assets/brain-solid.svg',
                    width: 32, height: 32)),
          ),
          Padding(
            padding: EdgeInsets.only(top: widget.screenWidth * 0.03),
            child: Center(
                child: Text('Ask FinBro',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.025))),
          )
        ],
      ),
    );
  }
}

class BudgetBroButton extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const BudgetBroButton(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<BudgetBroButton> createState() => _BudgetBroButton();
}

class _BudgetBroButton extends State<BudgetBroButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.screenWidth * 0.15,
          height: widget.screenWidth * 0.15,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(148, 171, 229, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: SvgPicture.asset(
            'assets/chart-pie-solid-feature-button.svg',
            width: 32,
            height: 32,
          )),
        ),
        Padding(
          padding: EdgeInsets.only(top: widget.screenWidth * 0.03),
          child: Center(
              child: Text('BudgetBro',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.screenWidth * 0.025))),
        )
      ],
    );
  }
}

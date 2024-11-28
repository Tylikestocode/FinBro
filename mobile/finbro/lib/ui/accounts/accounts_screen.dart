import 'package:finbro/domain/account.dart';
import 'package:finbro/ui/accounts/accounts_controller.dart';
import 'package:finbro/ui/accounts/add_account_screen.dart';
import 'package:finbro/ui/accounts/edit_account_screen.dart';
import 'package:finbro/ui/components/custom_drawer.dart';
import 'package:flutter/material.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {

  final AccountsController _accountsController = AccountsController();

  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  void loadAccounts() async {
    await _accountsController.loadAccounts();
    setState(() {
    });
  }

  final List<Map<String, dynamic>> _accounts = [
    {"name": "Savings", "balance": 1200.50},
    {"name": "Checking", "balance": 850.75},
    {"name": "Investments", "balance": 3400.00},
  ];

  void _addAccount() async {

    bool result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddAccountScreen()));

    if (result) {
      loadAccounts();
    }

  }
  void _updateAccount(Account account) async {

    bool result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditAccountScreen(account: account))
    );

    if (result) {
      loadAccounts();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 48, 100, 1), // primary
        foregroundColor: Colors.white,
        title: const Text(
          'Accounts',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
          children: [
            // Centered Total Balance
            Column(
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(27, 48, 100, 1), // primary
                  ),
                ),
                Text(
                  "R ${_accountsController.getTotal().toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 43, 153, 1), // secondary
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Accounts List
            Expanded(
              child: ListView.builder(
                itemCount: _accountsController.accountsList.length,
                itemBuilder: (context, index) {
                  final account = _accountsController.accountsList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      title: Text(
                        account.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(27, 48, 100, 1), // primary
                        ),
                      ),
                      trailing: Text(
                        "R ${account.balance}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 43, 153, 1), // secondary
                        ),
                      ),
                      onTap: () {
                        // Navigate to the AddAccountScreen and pass the accountId
                        _updateAccount(account);
                      },
                    ),
                  );
                },
              ),

            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0), // Adjust the bottom padding
        child: FloatingActionButton(
          onPressed: () {
            _addAccount();
          },
          backgroundColor: const Color.fromRGBO(27, 48, 100, 1), // primary
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}

import 'package:flutter/material.dart';

class HomeScreenTest extends StatefulWidget {
  const HomeScreenTest({super.key});

  @override
  State<HomeScreenTest> createState() => _HomeScreenTestState();
}

class _HomeScreenTestState extends State<HomeScreenTest> {
  String selectedAccount = "Main Account"; // Sample account dropdown option
  final List<String> accountList = ["Main Account", "Savings", "Investments"]; // Sample list of accounts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Drawer for side menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'FinBro Menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text('Accounts'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Accounts screen
              },
            ),
            ListTile(
              title: const Text('Categories'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Categories screen
              },
            ),
            ListTile(
              title: const Text('Regular Payments'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Regular Payments screen
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Profile screen
              },
            ),
          ],
        ),
      ),
      // AppBar with hamburger menu and account selector
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.blue),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: DropdownButton<String>(
          value: selectedAccount,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          onChanged: (String? newValue) {
            setState(() {
              selectedAccount = newValue!;
              // Trigger any additional account-switching logic
            });
          },
          items: accountList.map<DropdownMenuItem<String>>((String account) {
            return DropdownMenuItem<String>(
              value: account,
              child: Text(account),
            );
          }).toList(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Balance Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Balance',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'R 5,436.35', // Placeholder for dynamic balance
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Recent Transactions Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Recent Transactions List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 15, // Placeholder for transaction count
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.money, color: Colors.blue),
                    title: Text('Transaction #$index'),
                    subtitle: const Text('Description here'),
                    trailing: const Text(
                      '- R 150.00',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Quick Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle, size: 40, color: Colors.blue),
                  onPressed: () {
                    // Navigate to Add Transaction screen
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.account_balance, size: 40, color: Colors.blue),
                  onPressed: () {
                    // Navigate to Account Details
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.category, size: 40, color: Colors.blue),
                  onPressed: () {
                    // Do nothing
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

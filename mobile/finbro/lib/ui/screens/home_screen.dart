import 'package:finbro/ui/components/data_components.dart';
import 'package:finbro/ui/screens/ai_chat.dart';
import 'package:finbro/ui/screens/home_screen_test.dart';
import 'package:finbro/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  String selectedAccount = "Main Account"; // Sample account dropdown option
  final List<String> accountList = ["Main Account", "Savings", "Investments"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
            ListTile(
              title: const Text('test page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const HomeScreenTest()));
              },
            ),
          ],
        ),
      ),
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
      body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(0, 12, 42, 1),
            Color.fromRGBO(35, 61, 128, 1)
          ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
          child: Column(
            children: [
              // Balance
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.15),
                child: BalanceCard(
                    screenWidth: screenWidth, screenHeight: screenHeight),
              ),
              // Feature Buttons
              Padding(
                padding: EdgeInsets.only(
                    top: screenWidth * 0.025, bottom: screenWidth * 0.025),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenWidth * 0.15,
                        top: screenWidth * 0.08,
                        bottom: screenWidth * 0.08),
                    child: NewTransactionButton(
                        screenWidth: screenWidth, screenHeight: screenHeight),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenWidth * 0.08, bottom: screenWidth * 0.08),
                    child: FinBroButton(
                        screenWidth: screenWidth, screenHeight: screenHeight),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.15,
                        top: screenWidth * 0.08,
                        bottom: screenWidth * 0.08),
                    child: BudgetBroButton(
                        screenWidth: screenWidth, screenHeight: screenHeight),
                  ),
                ]),
              ),
              // Recent Transactions FinBro
              Expanded(
                child: RecentTransactionsListView(
                    screenWidth: screenWidth, screenHeight: screenHeight),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, size: 40, color: Colors.white),
                      onPressed: () {
                        // Navigate to Add Transaction screen
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, size: 40, color: Colors.white),
                      onPressed: () {
                        // Navigate to Account Details
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, size: 40, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),

    );
  }
}




class BalanceCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const BalanceCard(
      {super.key, required this.screenWidth, required this.screenHeight});
  @override
  State<BalanceCard> createState() => _BalanceCard();
}

class _BalanceCard extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: widget.screenWidth * 0.01),
        child: Text('Balance',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: widget.screenWidth * 0.03)),
      ),
      Text('R 5436,35',
          style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: widget.screenWidth * 0.1))
    ]);
  }
}

class NewTransactionButton extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const NewTransactionButton(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<NewTransactionButton> createState() => _NewTransactionButton();
}

class _NewTransactionButton extends State<NewTransactionButton> {
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
              child: SvgPicture.asset('assets/square-plus-solid.svg',
                  width: 36, height: 36)),
        ),
        Padding(
          padding: EdgeInsets.only(top: widget.screenWidth * 0.03),
          child: Center(
              child: Text('Add',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.screenWidth * 0.025))),
        )
      ],
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

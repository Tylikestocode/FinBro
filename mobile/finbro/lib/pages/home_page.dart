// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finbro/components/data_components.dart';
import 'package:finbro/components/navigation_components.dart';
import 'package:finbro/design/ui_colors.dart';
import 'package:finbro/pages/AI_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(213, 231, 243, 1), width: 2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GNav(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                tabBackgroundColor: primary,
                tabActiveBorder:
                    Border.all(color: Color.fromRGBO(213, 231, 243, 1)),
                backgroundColor: Colors.white,
                tabBorderRadius: 30,
                color: Color.fromRGBO(213, 231, 243, 1),
                iconSize: 24,
                activeColor: Colors.white,
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                    textStyle: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.normal),
                    gap: 6,
                  ),
                  GButton(
                    icon: LineIcons.lineChart,
                    text: 'Budget',
                    textStyle: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.normal),
                    gap: 6,
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                    textStyle: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.normal),
                    gap: 6,
                  )
                ],
              ),
            ),
          ),
        ),
        body: Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth * 0.15,
                              top: screenWidth * 0.08,
                              bottom: screenWidth * 0.08),
                          child: NewTransactionButton(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenWidth * 0.08,
                              bottom: screenWidth * 0.08),
                          child: FinBroButton(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.15,
                              top: screenWidth * 0.08,
                              bottom: screenWidth * 0.08),
                          child: BudgetBroButton(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight),
                        ),
                      ]),
                ),
                // Recent Transactions FinBro
                Expanded(
                  child: RecentTransactionsListView(
                      screenWidth: screenWidth, screenHeight: screenHeight),
                ),
              ],
            )));
  }
}

class BalanceCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const BalanceCard(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);
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
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

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
              color: Color.fromRGBO(148, 171, 229, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: SvgPicture.asset(
                  'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\square-plus-solid.svg',
                  width: 36,
                  height: 36)),
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
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<FinBroButton> createState() => _FinBroButton();
}

class _FinBroButton extends State<FinBroButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AiChat()));
      },
      child: Column(
        children: [
          Container(
            width: widget.screenWidth * 0.15,
            height: widget.screenWidth * 0.15,
            decoration: BoxDecoration(
                color: Color.fromRGBO(148, 171, 229, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: SvgPicture.asset(
                    'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\brain-solid.svg',
                    width: 32,
                    height: 32)),
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
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

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
              color: Color.fromRGBO(148, 171, 229, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: SvgPicture.asset(
            'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\chart-pie-solid-feature-button.svg',
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

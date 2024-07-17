// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finbro/components/list_view_components.dart';
import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class BalanceCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const BalanceCard(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.screenWidth * 0.9,
        height: widget.screenHeight * 0.25,
        decoration: BoxDecoration(
          color: third,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Balance',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Align(
              alignment: Alignment.center,
              child: Text('R 5320.33',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 32))),
            ),
          )
        ]));
  }
}

class RecentTransactions extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  RecentTransactions(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<RecentTransactions> createState() => _RecentTransactions();
}

class _RecentTransactions extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: widget.screenWidth * 0.88,
        height: widget.screenHeight * 0.55,
        decoration: BoxDecoration(color: third),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Recent Transaction Text
          Text('Recent Transactions',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.screenWidth * 0.038))),
          Expanded(
            child: Container(
                width: widget.screenWidth,
                height: widget.screenHeight,
                decoration: BoxDecoration(color: Colors.white),
                child: Expanded(
                  child: ListView(children: [
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                  ]),
                )),
          )
        ]),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:finbro/components/list_view_components.dart';
import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: third,
      child: Column(children: [
        SizedBox(height: screenHeight * 0.05),
        // Welcome Back Text and Profile Icon
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
          child: Row(children: [
            SizedBox(width: screenWidth * 0.07),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.05))),
                Text("johndoe@gmail.com",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.03))),
              ],
            ),
            SizedBox(width: screenWidth * 0.31),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
              child: Container(
                  width: screenWidth * 0.18,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Icon(UniconsLine.head_side,
                          size: screenWidth * 0.09))),
            ),
            SizedBox(width: screenWidth * 0.05)
          ]),
        ),
        // Balance Card
        Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
                color: secondary, borderRadius: BorderRadius.circular(30))),
        // Recent Expenses
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                  color: secondary, borderRadius: BorderRadius.circular(30)),
              child: ListView(children: [
                FinBroListViewItem(
                    screenWidth: screenWidth, screenHeight: screenHeight),
                FinBroListViewItem(
                    screenWidth: screenWidth, screenHeight: screenHeight),
                FinBroListViewItem(
                    screenWidth: screenWidth, screenHeight: screenHeight),
                FinBroListViewItem(
                    screenWidth: screenWidth, screenHeight: screenHeight),
                FinBroListViewItem(
                    screenWidth: screenWidth, screenHeight: screenHeight),
              ]),
            ),
          ),
        )
      ]),
    );
  }
}

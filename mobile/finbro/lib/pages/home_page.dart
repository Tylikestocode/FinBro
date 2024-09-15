// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finbro/components/data_components.dart';
import 'package:finbro/components/navigation_components.dart';
import 'package:finbro/design/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: primary,
      body: Column(
        children: [
          // Welcome Text
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.03, top: screenWidth * 0.1),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Hi John!',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.06))),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.03),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Welcome Back',
                    style: GoogleFonts.poppins(
                        color: Color.fromRGBO(79, 114, 204, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.05))),
          ),
          SizedBox(height: screenHeight * 0.293),
          // Balance Section
          // Graph and Analytics Section
          // Navigation Bar
          RecentTransactionListView(
              screenWidth: screenWidth, screenHeight: screenHeight),
          FinBroNavigationBar(
              screenWidth: screenWidth, screenHeight: screenHeight)
        ],
      ),
    );
  }
}

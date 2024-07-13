// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finbro/pages/ai.dart';
import 'package:finbro/pages/analytics.dart';
import 'package:finbro/pages/home_page.dart';
import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:unicons/unicons.dart';

class PageRouter extends StatefulWidget {
  const PageRouter({super.key});

  @override
  State<PageRouter> createState() => _PageRouter();
}

class _PageRouter extends State<PageRouter> {
  int Index = 0;
  List _pages = [HomePage(), AnalyticsPage(), AI()];

  void ChangePage(int index) {
    setState(() {
      Index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: _pages[Index],
        backgroundColor: secondary,
        bottomNavigationBar: GNav(
          tabMargin: EdgeInsets.all(8),
          gap: 8.0,
          activeColor: Colors.white,
          onTabChange: ChangePage,
          tabs: [
            GButton(
                icon: UniconsLine.home,
                text: 'Home',
                iconColor: third,
                iconSize: screenWidth * 0.07,
                textStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            GButton(
                icon: UniconsLine.analysis,
                iconSize: screenWidth * 0.07,
                text: 'Analytics',
                iconColor: third,
                textStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            GButton(
                icon: UniconsLine.robot,
                iconSize: screenWidth * 0.07,
                text: 'AI',
                iconColor: third,
                textStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ],
        ));
  }
}

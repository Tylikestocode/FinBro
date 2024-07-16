// ignore_for_file: prefer_const_constructors

import 'package:finbro/components/main_components.dart';
import 'package:finbro/pages/balance.dart';
import 'package:finbro/pages/profile.dart';
import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
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
        SizedBox(height: screenHeight * 0.03),
        // Welcome Back Text and Profile Icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(children: [
            SizedBox(width: screenWidth * 0.08),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.053))),
                Text("johndoe@gmail.com",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.035))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageAnimationTransition(
                          page: ProfilePage(),
                          pageAnimationType: RightToLeftTransition()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 60, top: 5),
                  child: Container(
                      width: screenWidth * 0.18,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Icon(UniconsLine.head_side,
                              size: screenWidth * 0.09, color: primary))),
                ),
              ),
            ),
            Expanded(child: SizedBox(width: 10)),
          ]),
        ),
        // Balance Card
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageAnimationTransition(
                      page: BalancePage(),
                      pageAnimationType: FadeAnimationTransition()));
            },
            child: BalanceCard(
                screenWidth: screenWidth, screenHeight: screenHeight)),
        // Recent Expenses
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                  color: secondary, borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Text('Recent Expenses',
                      style: TextStyle(color: Colors.white))),
            ),
          ),
        )
      ]),
    );
  }
}

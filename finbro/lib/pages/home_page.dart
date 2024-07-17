// ignore_for_file: prefer_const_constructors

import 'package:finbro/components/main_components.dart';
import 'package:finbro/pages/balance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

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
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\finbro\\assets\\background.png"),
              fit: BoxFit.cover)),
      child: Column(children: [
        SizedBox(height: screenHeight * 0.1),
        GestureDetector(
            onTap: () async {
              Navigator.push(
                  context,
                  PageAnimationTransition(
                      page: BalancePage(),
                      pageAnimationType: FadeAnimationTransition()));
            },
            child: BalanceCard(
                screenWidth: screenWidth, screenHeight: screenHeight)),
        SizedBox(height: screenHeight * 0.02),
        RecentTransactions(
            screenWidth: screenWidth, screenHeight: screenHeight),
      ]),
    );
  }
}

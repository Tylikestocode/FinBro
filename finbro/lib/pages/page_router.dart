// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finbro/pages/ai.dart';
import 'package:finbro/pages/analytics.dart';
import 'package:finbro/pages/home_page.dart';
import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:unicons/unicons.dart';

class PageRouter extends StatefulWidget {
  const PageRouter({super.key});

  @override
  State<PageRouter> createState() => _PageRouter();
}

class _PageRouter extends State<PageRouter> {
  bool homePressed = true;
  bool analyticsPressed = false;
  bool aiPressed = false;

  int Index = 0;
  List _pages = [HomePage(), AnalyticsPage(), AI()];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: _pages[Index],
        backgroundColor: third,
        bottomNavigationBar: Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.1,
            color: secondary,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.08,
                  decoration: BoxDecoration(
                      color: third, borderRadius: BorderRadius.circular(16)),
                  child: Row(children: [
                    // Home Icon
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                              color: homePressed ? primary_half : third,
                              borderRadius: BorderRadius.circular(15)),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                homePressed = true;
                                analyticsPressed = false;
                                aiPressed = false;
                                Index = 0;
                              });
                            },
                            child: Center(
                                child: Icon(UniconsLine.home,
                                    size: screenWidth * 0.09,
                                    color:
                                        homePressed ? primary : Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    // Analytics Icon
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                              color: analyticsPressed ? primary_half : third,
                              borderRadius: BorderRadius.circular(15)),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                homePressed = false;
                                analyticsPressed = true;
                                aiPressed = false;
                                Index = 1;
                              });
                            },
                            child: Center(
                                child: Icon(UniconsLine.graph_bar,
                                    size: screenWidth * 0.09,
                                    color: analyticsPressed
                                        ? primary
                                        : Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    // AI Assistant Icon
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                              color: aiPressed ? primary_half : third,
                              borderRadius: BorderRadius.circular(15)),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                homePressed = false;
                                analyticsPressed = false;
                                aiPressed = true;
                                Index = 2;
                              });
                            },
                            child: Center(
                                child: Icon(UniconsLine.robot,
                                    size: screenWidth * 0.09,
                                    color: aiPressed ? primary : Colors.black)),
                          ),
                        ),
                      ),
                    ),
                  ])),
            )));
  }
}

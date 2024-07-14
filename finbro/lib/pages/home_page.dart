// ignore_for_file: prefer_const_constructors

import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      color: secondary,
      child: Column(children: [
        SizedBox(height: screenHeight * 0.3),
        // Welcome Back Text and Profile Icon
        Row(children: [
          SizedBox(width: screenWidth * 0.1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05))),
              Text("johndoe@gmail.com",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.03)))
            ],
          ),
        ]),
        // Balance Card
        Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
                color: third, borderRadius: BorderRadius.circular(30))),
      ]),
    );
  }
}

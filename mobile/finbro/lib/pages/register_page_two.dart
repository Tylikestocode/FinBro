// ignore_for_file: prefer_const_constructors

import 'package:finbro/components/input_output.dart';
import 'package:finbro/design/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPageTwo extends StatefulWidget {
  const SignUpPageTwo({super.key});

  @override
  State<SignUpPageTwo> createState() => _SignUpPageTwo();
}

class _SignUpPageTwo extends State<SignUpPageTwo> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Sign Up Text
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                bottom: screenWidth * 0.1,
                top: screenWidth * 0.1),
            child: Text('Sign Up',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.1))),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, bottom: screenWidth * 0.1),
            child: FirstNameTextField(
                screenWidth: screenWidth, screenHeight: screenHeight),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, bottom: screenWidth * 0.1),
            child: SurnameTextField(
                screenWidth: screenWidth, screenHeight: screenHeight),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, bottom: screenWidth * 0.1),
            child: ProfessionTextField(
                screenWidth: screenWidth, screenHeight: screenHeight),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, bottom: screenWidth * 0.1),
            child: AgeTextField(
                screenWidth: screenWidth, screenHeight: screenHeight),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, bottom: screenWidth * 0.15),
            child: GenderTextField(
                screenWidth: screenWidth, screenHeight: screenHeight),
          ),
          Center(
              child: SignUpButton(
                  screenWidth: screenWidth, screenHeight: screenHeight))
        ]));
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:finbro/components/input_ouput.dart";
import "package:finbro/styles/color_scheme.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:google_fonts/google_fonts.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: secondary,
      body: Column(children: [
        SizedBox(height: screenHeight * 0.1),
        // Logo
        Center(
            child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\finbro\\assets\\image_placeholder.png'))))),
        SizedBox(height: screenHeight * 0.05),
        // Welcome Back Text
        Center(
            child: Text('Welcome Back',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.08)))),
        // Enter your details Text
        Center(
            child: Text('Please enter your details',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04)))),
        SizedBox(height: screenHeight * 0.05),
        // Email TextField
        Center(
          child: FinBroTextField(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              text: 'Email'),
        ),
        SizedBox(height: screenHeight * 0.035),
        // Password TextField
        Center(
            child: FinBroTextField(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                text: 'Password')),
        SizedBox(height: screenHeight * 0.05),

        // Continue Button
        FinBroButton(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            buttonText: 'Continue'),
        SizedBox(height: screenHeight * 0.13),

        // No Account? Sign Up Text
        GestureDetector(
          onTap: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
                child: Text('No Account?',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04)))),
            SizedBox(width: screenWidth * 0.01),
            Center(
                child: Text('Sign Up',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04))))
          ]),
        ),
        SizedBox(height: screenHeight * 0.01)
      ]),
    );
  }
}

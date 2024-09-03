// ignore_for_file: prefer_const_constructors

import "package:finbro/components/input_output.dart";
import "package:finbro/design/ui_colors.dart";
import "package:flutter/material.dart";
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // FinBro Logo
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.3,
              decoration: BoxDecoration(color: Colors.grey)),
        ),
        // Login Text
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              bottom: screenWidth * 0.05,
              top: screenWidth * 0.05),
          child: Text('Login',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.12))),
        ),
        // Email TextField
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05, bottom: screenWidth * 0.1),
          child: emailTextField(
              screenWidth: screenWidth, screenHeight: screenHeight),
        ),
        // Password TextField
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05, bottom: screenWidth * 0.1),
          child: passwordTextField(
              screenWidth: screenWidth, screenHeight: screenHeight),
        ),
        // Login Button
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.3),
              child: LoginButton(
                  screenWidth: screenWidth, screenHeight: screenHeight),
            )),
        // No Account? Sign Up
        TextButton(
            onPressed: () {},
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.01),
                child: Text('No Account?',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04)),
              ),
              Text('Sign Up',
                  style: GoogleFonts.poppins(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04))
            ]))
      ]),
    );
  }
}

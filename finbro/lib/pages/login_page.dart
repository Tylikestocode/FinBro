// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:finbro/components/input_ouput.dart";
import "package:finbro/styles/color_scheme.dart";
import "package:flutter/material.dart";

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
        SizedBox(height: screenHeight * 0.5),
        // Logo
        // Welcome Back Text
        // Enter your details Text
        // Email TextField
        Center(
          child: FinBroTextField(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              text: 'Email'),
        ),
        SizedBox(height: screenHeight * 0.01),
        // Password TextField
        Center(
            child: FinBroTextField(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                text: 'Password')),
        // Continue Button
        // No Account? Sign Up Text
      ]),
    );
  }
}

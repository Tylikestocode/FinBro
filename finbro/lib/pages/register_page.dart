// ignore_for_file: prefer_const_constructors

import "package:finbro/components/input_output.dart";
import "package:finbro/design/ui_colors.dart";
import "package:finbro/pages/login_page.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // FinBro Logo
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.3,
              decoration: BoxDecoration(color: Colors.grey)),
        ),
        // Sign Up Text
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              bottom: screenWidth * 0.05,
              top: screenWidth * 0.05),
          child: Text('Sign Up',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.11))),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05, bottom: screenWidth * 0.1),
          child: emailTextField(
              screenWidth: screenWidth, screenHeight: screenHeight),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05, bottom: screenWidth * 0.1),
          child: passwordTextField(
              screenWidth: screenWidth, screenHeight: screenHeight),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05, bottom: screenWidth * 0.1),
          child: passwordTextField(
              screenWidth: screenWidth, screenHeight: screenHeight),
        ),
        Center(
            child: Padding(
          padding: EdgeInsets.only(bottom: screenWidth * 0.1),
          child: ContinueButton(
              screenWidth: screenWidth, screenHeight: screenHeight),
        )),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.01),
                child: Text('Got an Account?',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035)),
              ),
              Text('Login',
                  style: GoogleFonts.poppins(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035))
            ]))
      ]),
    );
  }
}

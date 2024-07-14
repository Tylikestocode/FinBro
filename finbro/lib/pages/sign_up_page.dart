// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:finbro/components/input_ouput.dart";
import "package:finbro/pages/login_page.dart";
import "package:finbro/pages/page_router.dart";
import "package:finbro/styles/color_scheme.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:page_animation_transition/animations/left_to_right_transition.dart";
import "package:page_animation_transition/page_animation_transition.dart";

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
      backgroundColor: third,
      body: Column(children: [
        SizedBox(height: screenHeight * 0.07),
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
        // Registration Text
        Center(
            child: Text('Registration',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
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
        SizedBox(height: screenHeight * 0.035),
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
        SizedBox(height: screenHeight * 0.035),
        // Confirm Password
        Center(
          child: FinBroTextField(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              text: 'Confirm Password'),
        ),
        SizedBox(height: screenHeight * 0.035),
        // Continue Button
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PageRouter()));
          },
          child: FinBroButton(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              buttonText: 'Continue'),
        ),
        SizedBox(height: screenHeight * 0.07),

        // No Account? Sign Up Text
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageAnimationTransition(
                    page: LoginPage(),
                    pageAnimationType: LeftToRightTransition()));
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
                child: Text('Got an Account?',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04)))),
            SizedBox(width: screenWidth * 0.01),
            Center(
                child: Text('Login In',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04))))
          ]),
        ),
      ]),
    );
  }
}

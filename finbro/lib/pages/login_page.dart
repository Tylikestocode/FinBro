// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:finbro/components/input_ouput.dart";
import "package:finbro/pages/page_router.dart";
import "package:finbro/pages/sign_up_page.dart";
import "package:finbro/services/authentication.dart";
import "package:finbro/styles/color_scheme.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:page_animation_transition/animations/right_to_left_transition.dart";
import "package:page_animation_transition/page_animation_transition.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool loggedIn = false;
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void authenticate(String email, String password) async {
      bool result = await loginUser(email, password);
      setState(() {
        loggedIn = result;
      });
      if (loggedIn) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PageRouter()));
      } else {
        // Handle login failure (e.g., show a snackbar or error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Login failed. Please check your credentials.')),
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        // Welcome Back Text
        Center(
            child: Text('Welcome Back',
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
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035)))),
        SizedBox(height: screenHeight * 0.05),
        // Email TextField
        Center(
          child: FinBroTextField(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              text: 'Email',
              emailController: emailController),
        ),
        SizedBox(height: screenHeight * 0.035),
        // Password TextField
        Center(
            child: FinBroPasswordTextField(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                text: 'Password',
                passwordController: passwordController)),
        SizedBox(height: screenHeight * 0.05),

        // Continue Button
        GestureDetector(
          onTap: () {
            authenticate(emailController.text, passwordController.text);
          },
          child: FinBroButton(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              buttonText: 'Continue'),
        ),
        SizedBox(height: screenHeight * 0.15),

        // No Account? Sign Up Text
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageAnimationTransition(
                    page: SignUpPage(),
                    pageAnimationType: RightToLeftTransition()));
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
                child: Text('No Account?',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.black,
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
      ]),
    );
  }
}

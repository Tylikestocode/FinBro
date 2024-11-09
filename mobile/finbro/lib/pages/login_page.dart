// ignore_for_file: prefer_const_constructors

import "package:finbro/api/api_result.dart";
import "package:finbro/components/input_output.dart";
import "package:finbro/components/static_widgets.dart";
import "package:finbro/design/ui_colors.dart";
import "package:finbro/pages/home_page.dart";
import "package:finbro/pages/register_page.dart";
import "package:finbro/service/user_service.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  UserService userService = UserService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isSnackBarVisible = false;
  bool isLoading = false;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  void _handleLogin() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    ApiResult result = await userService.validateUserCredentials(email, password);

    print(result.success);

    setState(() {
      isLoading = false;
    });

    _handleLoginResult(result);
  }

  void _handleLoginResult(ApiResult result) {
    if (!mounted) return; // Check if widget is still in the tree

    if (!_isSnackBarVisible) {
      if (!result.success) {
        showSnackBar('User does not exist');
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }

  void showSnackBar(String message) {
    if (!_isSnackBarVisible) {
      _isSnackBarVisible = true;
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text(message),
              duration: Duration(seconds: 2),
            ),
          )
          .closed
          .then((_) {
        _isSnackBarVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: LogoWidget(width: screenWidth * 0.9, height: screenHeight * 0.3),
              ),
              // Login Label
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  bottom: screenWidth * 0.05,
                  top: screenWidth * 0.05,
                ),
                child: Text('Login',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.1))),
              ),
              // Email Text Field
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  bottom: screenWidth * 0.1,
                ),
                child: EmailTextField(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  emailController: emailController,
                  emailFocusNode: emailFocusNode,
                  passwordFocusNode: passwordFocusNode,
                ),
              ),
              // Password Text Field
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  bottom: screenWidth * 0.1,
                ),
                child: PasswordTextField(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  passwordController: passwordController,
                  passwordFocusNode: passwordFocusNode,
                ),
              ),
              // Login Button
              Align(
                alignment: Alignment.center,
                child: isLoading
                    ? CircularProgressIndicator()
                    : LoginButton(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        onTap: _handleLogin,
                      ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Sign up button
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.01),
                        child: Text('No Account?',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.035)),
                      ),
                      Text('Sign Up',
                          style: GoogleFonts.poppins(
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.035))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import "package:finbro/api/api_result.dart";
import "package:finbro/components/input_output.dart";
import "package:finbro/components/static_widgets.dart";
import "package:finbro/controller/login_page_controller.dart";
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
  LoginPageController loginPageController = LoginPageController();

  bool _isSnackBarVisible = false;
  bool _isLoading = false;

  void _handleLogin() async {

    String? message = loginPageController.validateFields();

    if (message != null) {
      _showSnackBar(message);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    ApiResult result = await loginPageController.handleLogin();

    setState(() {
      _isLoading = false;
    });

    _handleLoginResult(result);
  }

  void _handleLoginResult(ApiResult result) {
    if (!mounted) return; // Check if widget is still in the tree

    if (!_isSnackBarVisible) {
      if (!result.success) {
        _showSnackBar(result.errorMessage!);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }

  void _showSnackBar(String message) {
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
                child: LogoWidget(
                    width: screenWidth * 0.9, height: screenHeight * 0.3),
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
                  emailController: loginPageController.emailController,
                  emailFocusNode: loginPageController.emailFocusNode,
                  passwordFocusNode: loginPageController.passwordFocusNode,
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
                  passwordController: loginPageController.passwordController,
                  passwordFocusNode: loginPageController.passwordFocusNode,
                ),
              ),
              // Login Button
              Align(
                alignment: Alignment.center,
                child: _isLoading
                    ? LoadingButton(
                        screenWidth: screenWidth, screenHeight: screenHeight)
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

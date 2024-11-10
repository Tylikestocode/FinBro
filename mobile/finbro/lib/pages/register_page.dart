// ignore_for_file: prefer_const_constructors

import "package:finbro/api/api_result.dart";
import "package:finbro/components/input_output.dart";
import "package:finbro/components/static_widgets.dart";
import "package:finbro/controller/register_page_controller.dart";
import "package:finbro/design/ui_colors.dart";
import "package:finbro/pages/home_page.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  RegisterPageController registerPageController = RegisterPageController();

  bool _isSnackBarVisible = false;
  bool _isLoading = false;

  void _handleRegistration() async {

    String? message = registerPageController.validateFields();

    if (message != null) {
      _showSnackBar(message);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    ApiResult result = await registerPageController.handleRegistration();

    setState(() {
      _isLoading = false;
    });

    _handleRegistrationResult(result);
  }

  void _handleRegistrationResult(ApiResult result) {
    if (!mounted) return;

    if (!_isSnackBarVisible) {
      if (!result.success) {
        _showSnackBar(result.errorMessage!);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: LogoWidget(
                  width: screenWidth * 0.9, height: screenHeight * 0.3),
            ),
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
                          fontSize: screenWidth * 0.1))),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05, bottom: screenWidth * 0.1),
              child: EmailTextField(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                emailController: registerPageController.emailController,
                emailFocusNode: registerPageController.emailFocusNode,
                passwordFocusNode: registerPageController.passwordFocusNode,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05, bottom: screenWidth * 0.1),
              child: PasswordTextField(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                passwordController: registerPageController.passwordController,
                passwordFocusNode: registerPageController.passwordFocusNode,
                confirmPasswordFocusNode:
                    registerPageController.confirmPasswordFocusNode,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05, bottom: screenWidth * 0.1),
              child: ConfirmPasswordTextField(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                confirmPasswordController:
                    registerPageController.confirmPasswordController,
                confirmPasswordFocusNode:
                    registerPageController.confirmPasswordFocusNode,
              ),
            ),
            Align(
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.center,
              child: _isLoading
                  ? LoadingButton(
                      screenWidth: screenWidth, screenHeight: screenHeight)
                  : ContinueButton(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      onTap: _handleRegistration),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        )));
  }
}

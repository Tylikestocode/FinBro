import "package:finbro/api/api_result.dart";
import "package:finbro/other/input_output.dart";
import "package:finbro/ui/components/finbro_text_fields.dart";
import "package:finbro/ui/components/snack_bar_message.dart";
import "package:finbro/ui/components/static_widgets.dart";
import "package:finbro/ui/components/ui_colors.dart";
import "package:finbro/ui/auth/register_screen_controller.dart";
import "package:finbro/ui/screens/home_screen.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _SignUpPage();
}

class _SignUpPage extends State<RegisterScreen> {

  final RegisterPageController _registerPageController = RegisterPageController();
  final SnackBarMessage _snackBarMessage = SnackBarMessage();

  bool _isLoading = false;

  void _handleRegistration() async {
    String? message = _registerPageController.validateFields();

    if (message != null) {
      _snackBarMessage.showSnackBarMessage(context, message);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    ApiResult result = await _registerPageController.handleRegistration();

    setState(() {
      _isLoading = false;
    });

    _handleRegistrationResult(result);
  }

  void _handleRegistrationResult(ApiResult result) {
    if (!mounted) return;

    if (!result.success) {
      _snackBarMessage.showSnackBarMessage(context, result.errorMessage!);
    }
    else {
      _registerPageController.webSocketService.connectToWebSocket();
      Navigator.pushReplacement(
          context,
      MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      child: AuthTextField(
                          buildContext: context,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          controller: _registerPageController.emailController,
                          text: 'Email',
                          svgPath: 'assets/address-book-solid.svg',
                          obscureText: false,
                          thisFocusNode: _registerPageController.emailFocusNode,
                        nextFocusNode: _registerPageController.passwordFocusNode,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, bottom: screenWidth * 0.1),
                      child: AuthTextField(
                          buildContext: context,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          controller: _registerPageController.passwordController,
                          text: 'Password',
                          svgPath: 'assets/lock-solid.svg',
                          obscureText: true,
                          thisFocusNode: _registerPageController.passwordFocusNode,
                      nextFocusNode: _registerPageController.confirmPasswordFocusNode
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, bottom: screenWidth * 0.1),
                      child: AuthTextField(
                          buildContext: context,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          controller: _registerPageController.confirmPasswordController,
                          text: 'Confirm Password',
                          svgPath: 'assets/lock-solid.svg',
                          obscureText: true,
                          thisFocusNode: _registerPageController.confirmPasswordFocusNode
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: _isLoading
                          ? LoadingButton(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight)
                          : ContinueButton(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              onTap: _handleRegistration),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(right: screenWidth * 0.01),
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
            ),

            // Loading Overlay
            if (_isLoading)
              const ModalBarrier(
                dismissible: false,
              )
          ],
        )));
  }
}

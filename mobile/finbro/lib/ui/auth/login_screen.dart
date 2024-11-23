import "package:finbro/api/api_result.dart";
import "package:finbro/ui/components/finbro_text_fields.dart";
import "package:finbro/ui/components/snack_bar_message.dart";
import "package:finbro/ui/components/static_widgets.dart";
import "package:finbro/ui/components/ui_colors.dart";
import "package:finbro/ui/components/finbro_buttons.dart";
import "package:finbro/ui/auth/login_screen_controller.dart";
import "package:finbro/ui/screens/home_screen.dart";
import "package:finbro/ui/auth/register_screen.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPage();
}

class _LoginPage extends State<LoginScreen> {

  final LoginPageController _loginPageController = LoginPageController();
  final SnackBarMessage _snackBarMessage = SnackBarMessage();

  bool _isLoading = false;

  void _handleLogin() async {
    String? message = _loginPageController.validateFields();

    if (message != null) {
      _snackBarMessage.showSnackBarMessage(context, message);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    ApiResult result = await _loginPageController.handleLogin();

    setState(() {
      _isLoading = false;
    });

    _handleLoginResult(result);
  }

  void _handleLoginResult(ApiResult result) {
    if (!mounted) return;

    if (!result.success) {
      _snackBarMessage.showSnackBarMessage(context, result.errorMessage!);
    } else {
      _loginPageController.webSocketService.connectToWebSocket();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
            // Main Content
            SingleChildScrollView(
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
                    child: AuthTextField(
                        buildContext: context,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        controller: _loginPageController.emailController,
                        text: 'Email',
                        svgPath: 'assets/address-book-solid.svg',
                        obscureText: false,
                        thisFocusNode: _loginPageController.emailFocusNode,
                        nextFocusNode: _loginPageController.passwordFocusNode,
                    ),
                  ),
                  // Password Text Field
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      bottom: screenWidth * 0.1,
                    ),
                    child: AuthTextField(
                        buildContext: context,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        controller: _loginPageController.passwordController,
                        text: 'Password',
                        svgPath: 'assets/lock-solid.svg',
                        obscureText: true,
                        thisFocusNode: _loginPageController.passwordFocusNode
                    ),
                  ),
                  // Login Button
                  Align(
                    alignment: Alignment.center,
                    child: _isLoading
                        ? LoadingButton1(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight)
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
                      onPressed: _isLoading
                          ? null // Disable while loading
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()));
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

            // Loading Overlay
            if (_isLoading)
              const ModalBarrier(
                dismissible: false,
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:finbro/other/input_output.dart';
import 'package:finbro/ui/components/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _SignUpPageTwo();
}

class _SignUpPageTwo extends State<RegisterScreen2> {
  final TextEditingController ageController = TextEditingController();
  final FocusNode ageFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(  // Center widget added to vertically center the content
          child: SingleChildScrollView(
            child: ConstrainedBox(  // This ensures the column has a minimum height equal to the screen height
              constraints: BoxConstraints(
                minHeight: screenHeight,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,  // Vertically centers the column
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sign Up Text
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: screenWidth * 0.1,
                      ),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.1,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: screenWidth * 0.1,
                      ),
                      child: FirstNameTextField(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: screenWidth * 0.1,
                      ),
                      child: SurnameTextField(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                    // Age Text Field
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: screenWidth * 0.1,
                      ),
                      child: AgeTextField(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        ageController: ageController,
                        ageFocusNode: ageFocusNode,
                      ),
                    ),
                    Center(
                      child: SignUpButton(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

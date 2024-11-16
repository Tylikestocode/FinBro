import 'package:finbro/ui/components/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTap;

  const LoginButton(
      {super.key,
        required this.screenWidth,
        required this.screenHeight,
        required this.onTap});

  @override
  State<LoginButton> createState() => _LoginButton();
}

class _LoginButton extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.screenWidth * 0.6,
        height: widget.screenHeight * 0.065,
        decoration: BoxDecoration(
            color: primary, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text('Login',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035))),
      ),
    );
  }
}

class ContinueButton extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTap;

  const ContinueButton(
      {super.key,
        required this.screenWidth,
        required this.screenHeight,
        required this.onTap});

  @override
  State<ContinueButton> createState() => _ContinueButton();
}

class _ContinueButton extends State<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.screenWidth * 0.6,
        height: widget.screenHeight * 0.065,
        decoration: BoxDecoration(
            color: primary, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text('Continue',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035))),
      ),
    );
  }
}

class LoadingButton1 extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final bool isLoading; // Determines if the loading spinner should be shown

  const LoadingButton1({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    this.isLoading = false, // Defaults to not loading
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.6,
      height: screenHeight * 0.065,
      decoration: BoxDecoration(
        color: primary, // Replace `primary` with your desired color
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: SizedBox(
          width: 20.0, // Set the width to your desired size
          height: 20.0, // Set the height to your desired size
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }
}
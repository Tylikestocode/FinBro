import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finbro/design/ui_colors.dart';  // Make sure your colors are imported here

// Create a reusable logo widget
class LogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const LogoWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300], // Background color of the logo container
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Fin', // 'Fin' part of the logo
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: primary, // Primary color for "Fin"
                fontWeight: FontWeight.bold,
                fontSize: width * 0.15,
              ),
            ),
            children: [
              TextSpan(
                text: 'Bro', // 'Bro' part of the logo
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: secondary, // Secondary color for "Bro"
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.15,
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

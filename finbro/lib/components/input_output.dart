import 'package:finbro/design/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class emailTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const emailTextField(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<emailTextField> createState() => _emailTextField();
}

class _emailTextField extends State<emailTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.9,
      height: widget.screenHeight * 0.07,
      decoration: BoxDecoration(
          color: textFieldBack, borderRadius: BorderRadius.circular(15)),
      child: Row(children: [
        // Icon
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidth * 0.05,
                vertical: widget.screenWidth * 0.02),
            child: SvgPicture.asset(
              'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\finbro\\assets\\address-book-solid.svg', // Path to your SVG file
              width: 24,
              height: 24,
            )),
        // TextField
        Expanded(
            child: TextField(
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.04),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.04))))
      ]),
    );
  }
}

class passwordTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  bool eyeState;

  passwordTextField(
      {Key? key,
      required this.screenWidth,
      required this.screenHeight,
      this.eyeState = false})
      : super(key: key);

  @override
  State<passwordTextField> createState() => _passwordTextField();
}

class _passwordTextField extends State<passwordTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.9,
      height: widget.screenHeight * 0.07,
      decoration: BoxDecoration(
          color: textFieldBack, borderRadius: BorderRadius.circular(15)),
      child: Row(children: [
        // Icon
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widget.screenWidth * 0.05,
              vertical: widget.screenWidth * 0.02),
          child: SvgPicture.asset(
            'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\finbro\\assets\\lock-solid.svg',
            width: 24,
            height: 24,
          ),
        ),
        // TextField
        Expanded(
            child: TextField(
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.04),
                obscureText: widget.eyeState ? false : true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.04)))),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.eyeState = !widget.eyeState;
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidth * 0.05,
                vertical: widget.screenWidth * 0.02),
            child: widget.eyeState
                ? SvgPicture.asset(
                    'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\finbro\\assets\\eye-solid.svg',
                    width: 24,
                    height: 24,
                  )
                : SvgPicture.asset(
                    'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\finbro\\assets\\eye-slash-solid.svg', // Path to your SVG file
                    width: 24,
                    height: 24,
                  ),
          ),
        )
      ]),
    );
  }
}

class LoginButton extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const LoginButton(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButton();
}

class _LoginButton extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.8,
      height: widget.screenHeight * 0.07,
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: Text('Login',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.screenWidth * 0.05))),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:finbro/design/ui_colors.dart';
import 'package:finbro/pages/AI_chat.dart';
import 'package:finbro/pages/home_page.dart';
import 'package:finbro/pages/register_page_two.dart';
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
              'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\address-book-solid.svg',
              width: 24,
              height: 24,
            )),
        // TextField
        Expanded(
            child: TextField(
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035))))
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
            'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\lock-solid.svg',
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
                    fontSize: widget.screenWidth * 0.035),
                obscureText: widget.eyeState ? false : true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035)))),
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
                    'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\eye-solid.svg',
                    width: 24,
                    height: 24,
                  )
                : SvgPicture.asset(
                    'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\eye-slash-solid.svg', // Path to your SVG file
                    width: 24,
                    height: 24,
                  ),
          ),
        )
      ]),
    );
  }
}

class ConfirmPasswordTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  bool eyeState;

  ConfirmPasswordTextField(
      {Key? key,
      required this.screenWidth,
      required this.screenHeight,
      this.eyeState = false})
      : super(key: key);

  @override
  State<ConfirmPasswordTextField> createState() => _ConfirmPasswordTextField();
}

class _ConfirmPasswordTextField extends State<ConfirmPasswordTextField> {
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
            'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\lock-solid.svg',
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
                    fontSize: widget.screenWidth * 0.035),
                obscureText: widget.eyeState ? false : true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm Password',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035)))),
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
                    'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\eye-solid.svg',
                    width: 24,
                    height: 24,
                  )
                : SvgPicture.asset(
                    'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\eye-slash-solid.svg', // Path to your SVG file
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
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

  const ContinueButton(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<ContinueButton> createState() => _ContinueButton();
}

class _ContinueButton extends State<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPageTwo()));
      },
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

class FirstNameTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const FirstNameTextField(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<FirstNameTextField> createState() => _FirstNameTextField();
}

class _FirstNameTextField extends State<FirstNameTextField> {
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
              'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\address-book-solid.svg', // Path to your SVG file
              width: 24,
              height: 24,
            )),
        // TextField
        Expanded(
            child: TextField(
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'First Name',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035))))
      ]),
    );
  }
}

class SurnameTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const SurnameTextField(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<SurnameTextField> createState() => _SurnameTextField();
}

class _SurnameTextField extends State<SurnameTextField> {
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
              'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\address-book-solid.svg', // Path to your SVG file
              width: 24,
              height: 24,
            )),
        // TextField
        Expanded(
            child: TextField(
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Surname',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035))))
      ]),
    );
  }
}

class ProfessionTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const ProfessionTextField(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<ProfessionTextField> createState() => _ProfessionTextField();
}

class _ProfessionTextField extends State<ProfessionTextField> {
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
              'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\address-book-solid.svg', // Path to your SVG file
              width: 24,
              height: 24,
            )),
        // TextField
        Expanded(
            child: TextField(
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Profession',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035))))
      ]),
    );
  }
}

class AgeTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const AgeTextField(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<AgeTextField> createState() => _AgeTextField();
}

class _AgeTextField extends State<AgeTextField> {
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
              'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\address-book-solid.svg', // Path to your SVG file
              width: 24,
              height: 24,
            )),
        // TextField
        Expanded(
            child: TextField(
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Age',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035))))
      ]),
    );
  }
}

class GenderTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const GenderTextField(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<GenderTextField> createState() => _GenderTextField();
}

class _GenderTextField extends State<GenderTextField> {
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
              'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\address-book-solid.svg', // Path to your SVG file
              width: 24,
              height: 24,
            )),
        // TextField
        Expanded(
            child: TextField(
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Gender',
                    hintStyle: GoogleFonts.poppins(
                        color: textFieldTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035))))
      ]),
    );
  }
}

class SignUpButton extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const SignUpButton(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<SignUpButton> createState() => _SignUpButton();
}

class _SignUpButton extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: widget.screenWidth * 0.6,
        height: widget.screenHeight * 0.065,
        decoration: BoxDecoration(
            color: primary, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text('Sign Up',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035))),
      ),
    );
  }
}

class AiChatPromptTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const AiChatPromptTextField({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  State<AiChatPromptTextField> createState() => _AiChatPromptTextFieldState();
}

class _AiChatPromptTextFieldState extends State<AiChatPromptTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // TextField
        Padding(
          padding: EdgeInsets.only(
              left: widget.screenWidth * 0.06,
              right: widget.screenWidth * 0.05),
          child: Container(
            width: widget.screenWidth * 0.7,
            height: widget.screenHeight * 0.07,
            decoration: BoxDecoration(
                color: Color.fromRGBO(9, 23, 56, 1),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: EdgeInsets.only(
                  left: widget.screenWidth * 0.04,
                  top: widget.screenWidth * 0.02),
              child: TextField(
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: widget.screenWidth * 0.04),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Please Insert Your Prompt...',
                    hintStyle: GoogleFonts.poppins(
                        color: Color.fromRGBO(88, 97, 108, 1),
                        fontWeight: FontWeight.normal,
                        fontSize: widget.screenWidth * 0.035)),
              ),
            ),
          ),
        ),
        Container(
          width: widget.screenWidth * 0.14,
          height: widget.screenHeight * 0.065,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromRGBO(9, 23, 56, 1)),
          child: Center(
              child: SvgPicture.asset(
            'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\paper-plane-solid.svg', // Path to your SVG file
            width: 20,
            height: 20,
          )),
        )
        // Send Button
      ],
    );
  }
}

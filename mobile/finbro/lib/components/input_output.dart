// ignore_for_file: prefer_const_constructors

import 'package:finbro/design/ui_colors.dart';
import 'package:finbro/pages/register_page_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const EmailTextField(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.emailController,
      required this.emailFocusNode,
      required this.passwordFocusNode});

  @override
  State<EmailTextField> createState() => _EmailTextField();
}

class _EmailTextField extends State<EmailTextField> {
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
              'assets/address-book-solid.svg',
              width: 24,
              height: 24,
            )),
        // TextField
        Expanded(
            child: TextField(
                controller: widget.emailController,
                focusNode: widget.emailFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(widget.passwordFocusNode);
                },
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

class PasswordTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;

  const PasswordTextField(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.passwordController,
      required this.passwordFocusNode});

  @override
  State<PasswordTextField> createState() => _PasswordTextField();
}

class _PasswordTextField extends State<PasswordTextField> {
  bool eyeState = false;

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
            'assets/lock-solid.svg',
            width: 24,
            height: 24,
          ),
        ),
        // TextField
        Expanded(
            child: TextField(
              controller: widget.passwordController,
                focusNode: widget.passwordFocusNode,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                FocusScope.of(context).unfocus();
                },
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035),
                obscureText: eyeState ? false : true,
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
              eyeState = !eyeState;
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidth * 0.05,
                vertical: widget.screenWidth * 0.02),
            child: eyeState
                ? SvgPicture.asset(
                    'assets/eye-solid.svg',
                    width: 24,
                    height: 24,
                  )
                : SvgPicture.asset(
                    'assets/eye-slash-solid.svg', // Path to your SVG file
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

  const ConfirmPasswordTextField(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<ConfirmPasswordTextField> createState() => _ConfirmPasswordTextField();
}

class _ConfirmPasswordTextField extends State<ConfirmPasswordTextField> {
  bool eyeState = false;

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
            'assets/lock-solid.svg',
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
                obscureText: eyeState ? false : true,
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
              eyeState = !eyeState;
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidth * 0.05,
                vertical: widget.screenWidth * 0.02),
            child: eyeState
                ? SvgPicture.asset(
                    'assets/eye-solid.svg',
                    width: 24,
                    height: 24,
                  )
                : SvgPicture.asset(
                    'assets/eye-slash-solid.svg', // Path to your SVG file
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

  const ContinueButton(
      {super.key, required this.screenWidth, required this.screenHeight});

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
      {super.key, required this.screenWidth, required this.screenHeight});

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
              'assets/address-book-solid.svg', // Path to your SVG file
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
      {super.key, required this.screenWidth, required this.screenHeight});

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
              'assets/address-book-solid.svg', // Path to your SVG file
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
      {super.key, required this.screenWidth, required this.screenHeight});

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
              'assets/address-book-solid.svg', // Path to your SVG file
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
      {super.key, required this.screenWidth, required this.screenHeight});

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
              'assets/address-book-solid.svg', // Path to your SVG file
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
      {super.key, required this.screenWidth, required this.screenHeight});

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
              'assets/address-book-solid.svg', // Path to your SVG file
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
      {super.key, required this.screenWidth, required this.screenHeight});

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
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

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
            'assets/paper-plane-solid.svg', // Path to your SVG file
            width: 20,
            height: 20,
          )),
        )
        // Send Button
      ],
    );
  }
}

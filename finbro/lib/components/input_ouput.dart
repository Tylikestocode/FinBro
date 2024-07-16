// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class FinBroTextField extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String text;

  const FinBroTextField({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.text,
  }) : super(key: key);

  @override
  State<FinBroTextField> createState() => _FinBroTextFieldState();
}

class _FinBroTextFieldState extends State<FinBroTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.85,
      height: widget.screenHeight * 0.075,
      decoration: BoxDecoration(
          color: third,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: outline)),
      child: Row(children: [
        // Icon
        Container(
            width: widget.screenWidth * 0.15,
            height: widget.screenHeight * 0.08,
            decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1, color: outline)),
                color: third,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Icon(
              EvaIcons.email,
              size: widget.screenWidth * 0.08,
              color: outline,
            )),
        // TextField
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              cursorColor: outline,
              decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: outline,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.screenWidth * 0.04)),
                  border: InputBorder.none,
                  hintText: widget.text)),
        ))
      ]),
    );
  }
}

class FinBroButton extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String buttonText;

  const FinBroButton(
      {Key? key,
      required this.screenWidth,
      required this.screenHeight,
      required this.buttonText})
      : super(key: key);

  @override
  State<FinBroButton> createState() => _FinBroButton();
}

class _FinBroButton extends State<FinBroButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.45,
      height: widget.screenHeight * 0.07,
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(25)),
      child: Center(
          child: Text(widget.buttonText,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.screenWidth * 0.04)))),
    );
  }
}

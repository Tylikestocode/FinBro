// ignore_for_file: prefer_const_constructors

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
      width: widget.screenWidth * 0.8,
      height: widget.screenHeight * 0.1,
      decoration:
          BoxDecoration(color: third, borderRadius: BorderRadius.circular(30)),
      child: Row(children: [
        // Icon
        Container(
            width: widget.screenWidth * 0.15,
            height: widget.screenHeight * 0.1,
            decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1, color: outline)),
                color: third,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
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

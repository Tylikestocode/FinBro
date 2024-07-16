// ignore_for_file: prefer_const_constructors

import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BalanceCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const BalanceCard(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.screenWidth * 0.9,
        height: widget.screenHeight * 0.25,
        decoration: BoxDecoration(
            color: secondary, borderRadius: BorderRadius.circular(30)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Balance',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Align(
              alignment: Alignment.center,
              child: Text('R 5320.33',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 32))),
            ),
          )
        ]));
  }
}

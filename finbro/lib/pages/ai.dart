// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:finbro/components/main_components.dart';
import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AI extends StatefulWidget {
  const AI({super.key});

  @override
  State<AI> createState() => _AI();
}

class _AI extends State<AI> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: primary,
            foregroundColor: third,
            title: Text('AI Assistant'),
            centerTitle: true,
            titleTextStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: third,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05))),
        backgroundColor: third,
        body: Column(children: []));
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: secondary,
      child: Center(
          child: Text('Home Page', style: TextStyle(color: Colors.white))),
    );
  }
}

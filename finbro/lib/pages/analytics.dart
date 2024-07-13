// ignore_for_file: prefer_const_constructors

import "package:finbro/styles/color_scheme.dart";
import "package:flutter/material.dart";

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPage();
}

class _AnalyticsPage extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: secondary,
      child: Center(
          child: Text('Analytics', style: TextStyle(color: Colors.white))),
    );
  }
}

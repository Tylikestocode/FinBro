// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:finbro/components/main_components.dart';
import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: third,
        body: Column(children: [
          // Top NavBar
          SizedBox(height: screenHeight * 0.1),
          // Chat Box
          UserChatBubble(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              chatText: 'Hello, What is my name?'),
          AiChatBubble(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              responseText: 'Hello your name is!'),
          // Prompt Box
          PromptBox(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              prompt: 'Hello what is my name'),
        ]));
  }
}

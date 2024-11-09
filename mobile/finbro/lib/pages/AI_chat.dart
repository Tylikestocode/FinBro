// ignore_for_file: prefer_const_constructors

import "package:finbro/components/chat_components.dart";
import "package:finbro/components/input_output.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:google_fonts/google_fonts.dart";

class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(0, 12, 42, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Nav Bar
          Container(
            width: screenWidth,
            height: screenHeight * 0.08,
            decoration: BoxDecoration(color: Color.fromRGBO(9, 23, 56, 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Back Button
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: SvgPicture.asset(
                    'assets/arrow-left-solid.svg', // Path to your SVG file
                    width: 24,
                    height: 24,
                  ),
                ),

                // AI chat Text
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.15),
                  child: Text(
                    'FinBro AI Assistant',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.05),
                  ),
                ),
              ],
            ),
          ),
          // Chat Area
          Padding(
            padding: EdgeInsets.only(top: screenWidth * 0.04),
            child: AiChatBubble(
                screenWidth: screenWidth, screenHeight: screenHeight),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenWidth * 0.04),
            child: UserChatBubble(
                screenWidth: screenWidth, screenHeight: screenHeight),
          ),
          // Prompt Box
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: AiChatPromptTextField(
                screenWidth: screenWidth, screenHeight: screenHeight),
          ),
        ],
      ),
    );
  }
}

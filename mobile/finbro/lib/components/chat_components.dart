// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AiChatBubble extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const AiChatBubble(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<AiChatBubble> createState() => _AiChatBubbleState();
}

class _AiChatBubbleState extends State<AiChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.screenWidth * 0.97,
        height: widget.screenHeight * 0.18,
        decoration: BoxDecoration(
            color: Color.fromRGBO(27, 48, 100, 1),
            borderRadius: BorderRadius.circular(30)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // AI Icon
          Padding(
            padding: EdgeInsets.only(
                left: widget.screenWidth * 0.04,
                top: widget.screenWidth * 0.02),
            child: Container(
              width: widget.screenWidth * 0.115,
              height: widget.screenHeight * 0.05,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(62, 90, 162, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: SvgPicture.asset(
                  'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\robot-solid.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: widget.screenWidth * 0.05,
                top: widget.screenHeight * 0.01),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.01),
              child: Text(
                  'Hi, I’m FinBro your AI assistant here to help you navigate the complexities of personal finance how can I help?',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: widget.screenWidth * 0.035)),
            ),
          )
        ]),
      ),
    );
  }
}

class UserChatBubble extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const UserChatBubble(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<UserChatBubble> createState() => _UserChatBubble();
}

class _UserChatBubble extends State<UserChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.screenWidth * 0.97,
        height: widget.screenHeight * 0.18,
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 90, 162, 1),
            borderRadius: BorderRadius.circular(30)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // AI Icon
          Padding(
            padding: EdgeInsets.only(
                left: widget.screenWidth * 0.04,
                top: widget.screenWidth * 0.02),
            child: Container(
              width: widget.screenWidth * 0.115,
              height: widget.screenHeight * 0.05,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(27, 48, 100, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: SvgPicture.asset(
                  'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\person-solid.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: widget.screenWidth * 0.05,
                top: widget.screenHeight * 0.01),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.01),
              child: Text(
                  'How can I extend my money to the end of the month with my current financial situation? ',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: widget.screenWidth * 0.035)),
            ),
          )
        ]),
      ),
    );
  }
}

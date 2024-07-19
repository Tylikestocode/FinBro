// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finbro/components/list_view_components.dart';
import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class BalanceCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const BalanceCard(
      {super.key, required this.screenWidth, required this.screenHeight});

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
          color: third,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Balance',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
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
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 32))),
            ),
          )
        ]));
  }
}

class RecentTransactions extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const RecentTransactions(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<RecentTransactions> createState() => _RecentTransactions();
}

class _RecentTransactions extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: widget.screenWidth * 0.88,
        height: widget.screenHeight * 0.55,
        decoration: BoxDecoration(color: third),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Recent Transaction Text
          Text('Recent Transactions',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.screenWidth * 0.038))),
          Expanded(
            child: Container(
                width: widget.screenWidth,
                height: widget.screenHeight,
                decoration: BoxDecoration(color: Colors.white),
                child: Expanded(
                  child: ListView(children: [
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                    FinBroListViewItem(
                        screenWidth: widget.screenHeight,
                        screenHeight: widget.screenWidth),
                  ]),
                )),
          )
        ]),
      ),
    );
  }
}

class AiChatBubble extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String responseText;

  const AiChatBubble(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.responseText});

  @override
  State<AiChatBubble> createState() => _AiChatBubble();
}

class _AiChatBubble extends State<AiChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.screenWidth * 0.03,
          vertical: widget.screenWidth * 0.003),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: widget.screenWidth * 0.001),
              child: Text('AI Assistant',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.screenWidth * 0.03))),
            ),
            Container(
                width: widget.screenWidth * 0.7,
                height: widget.screenHeight * 0.06,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Padding(
                  padding: EdgeInsets.all(widget.screenWidth * 0.03),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.responseText,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: widget.screenWidth * 0.03)))),
                )),
          ],
        ),
      ),
    );
  }
}

class UserChatBubble extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String chatText;

  const UserChatBubble(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.chatText});

  @override
  State<UserChatBubble> createState() => _UserChatBubble();
}

class _UserChatBubble extends State<UserChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.screenWidth * 0.03,
          vertical: widget.screenWidth * 0.04),
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: widget.screenWidth * 0.07),
              child: Text('You',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: primarySecond,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.screenWidth * 0.03))),
            ),
            Container(
                width: widget.screenWidth * 0.7,
                height: widget.screenHeight * 0.06,
                decoration: BoxDecoration(
                    color: primarySecond,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Padding(
                  padding: EdgeInsets.all(widget.screenWidth * 0.03),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.chatText,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: widget.screenWidth * 0.03)))),
                )),
          ],
        ),
      ),
    );
  }
}

class PromptBox extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String prompt;

  const PromptBox(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.prompt});

  @override
  State<PromptBox> createState() => _PromptBox();
}

class _PromptBox extends State<PromptBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: widget.screenWidth * 0.7,
            height: widget.screenHeight * 0.07,
            decoration: BoxDecoration(
                color: Color.fromARGB(102, 197, 197, 197),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.5, horizontal: 20.0),
              child: TextField(
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035)),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your Prompt',
                    hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: widget.screenWidth * 0.035))),
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: widget.screenWidth * 0.14,
              height: widget.screenWidth * 0.14,
              decoration: BoxDecoration(
                  color: primaryHalf, borderRadius: BorderRadius.circular(30)),
              child: Icon(UniconsLine.arrow_circle_up,
                  size: widget.screenWidth * 0.09)),
        )
      ],
    );
  }
}

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  Future getMessages() async {
    return;
  }

  @override
  State<MessageList> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}

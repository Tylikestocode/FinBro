// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters

import 'package:finbro/design/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentTransactionsListView extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const RecentTransactionsListView(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<RecentTransactionsListView> createState() =>
      _RecentTransactionsListViewState();
}

class _RecentTransactionsListViewState
    extends State<RecentTransactionsListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth,
      height: widget.screenHeight,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        children: [
          // Recent Transactions and See All text
          Padding(
            padding: EdgeInsets.only(
                top: widget.screenWidth * 0.08,
                right: widget.screenWidth * 0.05,
                left: widget.screenWidth * 0.05),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: widget.screenWidth * 0.3),
                  child: Text('Last Transactions',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.screenWidth * 0.035)),
                ),
                Text('See all',
                    style: GoogleFonts.poppins(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.screenWidth * 0.035))
              ],
            ),
          ),
          // ListView Data
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.025),
              child: ListView(
                children: [
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                  ListViewContentBlock(
                      screenWidth: widget.screenWidth,
                      screenHeight: widget.screenHeight),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListViewContentBlock extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const ListViewContentBlock(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<ListViewContentBlock> createState() => _ListViewContentBlock();
}

class _ListViewContentBlock extends State<ListViewContentBlock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        width: widget.screenWidth * 0.8,
        height: widget.screenHeight * 0.08,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromRGBO(237, 237, 237, 1)),
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: [
            // Icon
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: widget.screenWidth * 0.15,
                height: widget.screenHeight * 0.08,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(148, 171, 229, 0.54),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            // Text
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text('Netflix',
                        style: GoogleFonts.poppins(
                            color: primary, fontWeight: FontWeight.bold)),
                    // Date
                    Text('4 March 2024',
                        style: GoogleFonts.poppins(
                            color: Color.fromRGBO(194, 198, 200, 1),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            // Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text('- R 99,99',
                  style: GoogleFonts.poppins(
                      color: Color.fromRGBO(240, 91, 94, 1),
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}

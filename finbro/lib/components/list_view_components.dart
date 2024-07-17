// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class FinBroListViewItem extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const FinBroListViewItem(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<FinBroListViewItem> createState() => _FinBroListViewItem();
}

class _FinBroListViewItem extends State<FinBroListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Container(
        width: widget.screenWidth * 0.9,
        height: widget.screenHeight * 0.15,
        decoration: BoxDecoration(
            color: third,
            border: Border(bottom: BorderSide(color: Colors.black))),
        child: Row(children: [
          Container(
              width: widget.screenWidth * 0.065,
              height: widget.screenHeight * 0.13,
              decoration: BoxDecoration(
                  color: ListColor, borderRadius: BorderRadius.circular(45)),
              child: Icon(UniconsLine.tv_retro)),
          SizedBox(width: widget.screenWidth * 0.01),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Youtube'), Text('Subscription')],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('R 99.99',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 96, 85),
                            fontWeight: FontWeight.bold,
                            fontSize: widget.screenWidth * 0.015))),
                Text('03/05/2024')
              ],
            ),
          )
        ]),
      ),
    );
  }
}

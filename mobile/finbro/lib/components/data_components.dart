// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RecentTransactionListView extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const RecentTransactionListView(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<RecentTransactionListView> createState() =>
      _RecentTransactionListView();
}

class _RecentTransactionListView extends State<RecentTransactionListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth,
      height: widget.screenHeight * 0.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    );
  }
}

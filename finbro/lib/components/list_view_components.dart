// ignore_for_file: use_super_parameters

import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        width: widget.screenWidth * 0.9,
        height: widget.screenHeight * 0.1,
        decoration: BoxDecoration(
            color: third, borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

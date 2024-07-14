// ignore_for_file: prefer_const_constructors

import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePage();
}

class _BalancePage extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: third,
      body: Center(child: Text('Balance Page')),
    );
  }
}

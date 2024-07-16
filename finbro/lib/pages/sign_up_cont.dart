// ignore_for_file: prefer_const_constructors

import 'package:finbro/styles/color_scheme.dart';
import 'package:flutter/material.dart';

class SignUpPageContinued extends StatefulWidget {
  const SignUpPageContinued({super.key});

  @override
  State<SignUpPageContinued> createState() => _SignUpPageContinuedState();
}

class _SignUpPageContinuedState extends State<SignUpPageContinued> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: third,
      body: Center(child: Text('Sign Up Continued')),
    );
  }
}

import 'package:finbro/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FinBro());
}

class FinBro extends StatelessWidget {
  const FinBro({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

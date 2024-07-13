// ignore_for_file: prefer_const_constructors

import 'package:finbro/pages/ai.dart';
import 'package:finbro/pages/analytics.dart';
import 'package:finbro/pages/home_page.dart';
import 'package:flutter/material.dart';

class PageRouter extends StatefulWidget {
  const PageRouter({super.key});

  @override
  State<PageRouter> createState() => _PageRouter();
}

class _PageRouter extends State<PageRouter> {
  int Index = 0;
  final List _pages = [HomePage(), AnalyticsPage(), AI()];

  void SwitchPage(int index) {
    setState(() {
      Index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: Index, onTap: SwitchPage, items: [
            BottomNavigationBarItem(icon: icon)
          ]),
      body: _pages[index],
    );
  }
}

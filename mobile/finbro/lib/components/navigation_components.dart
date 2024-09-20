// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:finbro/design/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FinBroNavigationBar extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  bool homeActive;
  bool budgetActive;
  bool profileActive;

  FinBroNavigationBar(
      {Key? key,
      required this.screenWidth,
      required this.screenHeight,
      this.homeActive = true,
      this.budgetActive = false,
      this.profileActive = false})
      : super(key: key);

  @override
  State<FinBroNavigationBar> createState() => _FinBroNavigationBar();
}

class _FinBroNavigationBar extends State<FinBroNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.screenWidth,
        height: widget.screenHeight * 0.08,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(
                    color: Color.fromRGBO(245, 245, 245, 1),
                    width: widget.screenWidth * 0.005))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Home Icon
            HomeActiveIconNavBar(
                screenWidth: widget.screenWidth,
                screenHeight: widget.screenHeight),
            // Budget Icon
            InActiveBudgetNavBar(
                screenWidth: widget.screenWidth,
                screenHeight: widget.screenHeight),
            // Profile Icon
            InActiveProfileNavBar(
                screenWidth: widget.screenWidth,
                screenHeight: widget.screenHeight)
          ],
        ));
  }
}

class HomeActiveIconNavBar extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const HomeActiveIconNavBar(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<HomeActiveIconNavBar> createState() => _HomeActiveIconNavBar();
}

class _HomeActiveIconNavBar extends State<HomeActiveIconNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: widget.screenWidth * 0.01,
          bottom: widget.screenWidth * 0.01,
          right: widget.screenWidth * 0.2),
      child: Container(
          width: widget.screenWidth * 0.15,
          height: widget.screenHeight * 0.065,
          decoration: BoxDecoration(
              color: primary, borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: widget.screenWidth * 0.015),
              child: SvgPicture.asset(
                'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\house-solid-active.svg',
                width: 20,
                height: 20,
              ),
            ),
            Text('Home',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.025))
          ])),
    );
  }
}

class InActiveBudgetNavBar extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const InActiveBudgetNavBar(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<InActiveBudgetNavBar> createState() => _InActiveBudgetNavBar();
}

class _InActiveBudgetNavBar extends State<InActiveBudgetNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.screenWidth * 0.01,
        bottom: widget.screenWidth * 0.01,
      ),
      child: Container(
          width: widget.screenWidth * 0.15,
          height: widget.screenHeight * 0.065,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\chart-simple-solid-inactive.svg',
              width: 36,
              height: 36,
            ),
          ])),
    );
  }
}

class InActiveProfileNavBar extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const InActiveProfileNavBar(
      {Key? key, required this.screenWidth, required this.screenHeight})
      : super(key: key);

  @override
  State<InActiveProfileNavBar> createState() => _InActiveProfileNavBar();
}

class _InActiveProfileNavBar extends State<InActiveProfileNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: widget.screenWidth * 0.01,
          bottom: widget.screenWidth * 0.01,
          left: widget.screenWidth * 0.2),
      child: Container(
          width: widget.screenWidth * 0.15,
          height: widget.screenHeight * 0.065,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\user-solid-inactive.svg',
              width: 36,
              height: 36,
            ),
          ])),
    );
  }
}

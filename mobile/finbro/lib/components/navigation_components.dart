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
        height: widget.screenHeight * 0.07,
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
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.homeActive = !widget.homeActive;
                  widget.budgetActive = false;
                  widget.profileActive = false;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(right: widget.screenWidth * 0.25),
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            widget.homeActive
                                ? 'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\house-solid-active.svg'
                                : 'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\house-solid-inactive.svg',
                            width: 30,
                            height: 30),
                        Text('Home',
                            style: GoogleFonts.poppins(
                                color: widget.homeActive
                                    ? primary
                                    : Color.fromRGBO(210, 215, 226, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: widget.screenWidth * 0.025))
                      ]),
                ),
              ),
            ),
            // Budget Icon
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.budgetActive = !widget.budgetActive;
                  widget.homeActive = false;
                  widget.profileActive = false;
                });
              },
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          widget.budgetActive
                              ? 'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\chart-simple-solid-active.svg'
                              : 'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\chart-simple-solid-inactive.svg',
                          width: 30,
                          height: 30),
                      Text('Budget',
                          style: GoogleFonts.poppins(
                              color: widget.budgetActive
                                  ? primary
                                  : Color.fromRGBO(210, 215, 226, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: widget.screenWidth * 0.025))
                    ]),
              ),
            ),
            // Profile Icon
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.profileActive = !widget.profileActive;
                  widget.homeActive = false;
                  widget.budgetActive = false;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(left: widget.screenWidth * 0.25),
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            widget.profileActive
                                ? 'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\person-solid-active.svg'
                                : 'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\mobile\\finbro\\assets\\person-solid-inactive.svg',
                            width: 30,
                            height: 30),
                        Text('Profile',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(210, 215, 226, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: widget.screenWidth * 0.025))
                      ]),
                ),
              ),
            ),
          ],
        ));
  }
}

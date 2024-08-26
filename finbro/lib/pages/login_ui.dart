// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:unicons/unicons.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.1, top: screenWidth * 0.1),
            child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'C:\\Users\\Tyron\\OneDrive\\Desktop\\FinBro\\FinBro\\finbro\\assets\\placeholder.png'),
                        fit: BoxFit.fill))),
          ),
          // Login Text
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.1,
                bottom: screenWidth * 0.05,
                top: screenWidth * 0.1),
            child: Text('Login',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Color.fromRGBO(0, 101, 255, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 40))),
          ),
          // Email Container
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.1, bottom: screenWidth * 0.08),
            child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(241, 245, 246, 1),
                    // ignore: prefer_const_literals_to_create_immutables
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: Icon(UniconsLine.envelope,
                          color: Colors.black, size: screenWidth * 0.07),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: TextField(
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color:
                                          Color.fromRGBO(123, 134, 148, 0.65),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)))),
                    ))
                  ],
                )),
          ),
          // Password Container
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.1, bottom: screenWidth * 0.08),
            child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(241, 245, 246, 1),
                    // ignore: prefer_const_literals_to_create_immutables
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: Icon(UniconsLine.lock,
                          color: Colors.black, size: screenWidth * 0.07),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: TextField(
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color:
                                          Color.fromRGBO(123, 134, 148, 0.65),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)))),
                    ))
                  ],
                )),
          ),
          // Login Button
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.1, bottom: screenWidth * 0.5),
            child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 101, 255, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text('Login',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))),
                )),
          ),
          GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.01),
                    child: Text('No Account?',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))),
                  ),
                  Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(0, 101, 255, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

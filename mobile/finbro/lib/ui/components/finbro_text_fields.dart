import 'package:finbro/ui/components/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatefulWidget {
  final BuildContext buildContext;
  final double screenWidth;
  final double screenHeight;
  final TextEditingController controller;
  final String text;
  final String svgPath;
  final bool obscureText;
  final FocusNode thisFocusNode;
  final FocusNode? nextFocusNode;

  const AuthTextField(
      {super.key,
      required this.buildContext,
      required this.screenWidth,
      required this.screenHeight,
      required this.controller,
      required this.text,
      required this.svgPath,
      required this.obscureText,
      required this.thisFocusNode,
      this.nextFocusNode});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.9,
      height: widget.screenHeight * 0.07,
      decoration: BoxDecoration(
          color: textFieldBack, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidth * 0.05,
                vertical: widget.screenWidth * 0.02),
            child: SvgPicture.asset(
              widget.svgPath,
              width: 24,
              height: 24,
            ),
          ),
          Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.thisFocusNode,
                textInputAction: TextInputAction.next,
                obscureText: _isObscured,
                onSubmitted: (_) {
                  if (widget.nextFocusNode != null) {
                    FocusScope.of(context).requestFocus(widget.nextFocusNode);
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                },
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.screenWidth * 0.035,
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.text,
                  hintStyle: GoogleFonts.poppins(
                    color: textFieldTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.screenWidth * 0.035,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: widget.screenHeight * 0.02,
                  ),
                  suffixIcon: widget.obscureText
                      ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.screenWidth * 0.05,
                        vertical: widget.screenWidth * 0.02,
                      ),
                      child: _isObscured
                          ? SvgPicture.asset(
                        'assets/eye-slash-solid.svg',
                        width: 24,
                        height: 24,
                      )
                          : SvgPicture.asset(
                        'assets/eye-solid.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  )
                      : null,
                ),
              )


          )
        ],
      ),
    );
  }
}

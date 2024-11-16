import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FinBroTextField extends StatefulWidget {
  final BuildContext buildContext;
  final String text;
  final double width;
  final double height;
  final TextEditingController textEditingController;
  final bool obscureText;
  final FocusNode thisFocusNode;
  final FocusNode? nextFocusNode;
  final String? customIcon;
  final Icon? flutterIcon;

  const FinBroTextField({
    super.key, required this.buildContext, required this.width, required this.height, required this.textEditingController, required this.obscureText, required this.thisFocusNode, this.nextFocusNode, this.customIcon, this.flutterIcon, required this.text,
  });

  @override
  State<FinBroTextField> createState() => _FinBroTextFieldState();
}

class _FinBroTextFieldState extends State<FinBroTextField> {

  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.width,
              vertical: widget.height,
            ),
            child: widget.customIcon != null
                ? SvgPicture.asset(
                    widget.customIcon!,
                    width: 24,
                    height: 24,
                  )
                : (widget.flutterIcon ?? const SizedBox.shrink()),
          ),
          // TextField
          Expanded(
            child: TextField(
              controller: widget.textEditingController,
              obscureText: _isObscured,
              focusNode: widget.thisFocusNode,
              onSubmitted: (_) {
                if (widget.nextFocusNode != null) {
                  FocusScope.of(widget.buildContext)
                      .requestFocus(widget.nextFocusNode);
                }
                else {
                  FocusScope.of(widget.buildContext).unfocus();
                }
              },
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: widget.width,
              ),
              decoration: InputDecoration(
                labelText: widget.text,
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins (
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.width
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}

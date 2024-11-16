import 'package:flutter/material.dart';

class SnackBarMessage {
  bool isVisible = false;

  void showSnackBarMessage(
      BuildContext buildContext, String message, [int seconds = 2]) {
    if (!isVisible) {
      isVisible = true;
      ScaffoldMessenger.of(buildContext)
          .showSnackBar(
            SnackBar(
              content: Text(message),
              duration: Duration(seconds: seconds),
            ),
          )
          .closed
          .then((_) {
        isVisible = false;
      });
    }
  }
}

import 'package:flutter/material.dart';

Widget buildLoadingScreen() {
  return Stack(
    children: [
      ModalBarrier(
        dismissible: false,
        color: Colors.black.withOpacity(0.5),
      ),
      const Center(
        child: CircularProgressIndicator(),
      )
    ],
  );
}
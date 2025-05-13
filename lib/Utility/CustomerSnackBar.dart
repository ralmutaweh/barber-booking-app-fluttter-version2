import 'package:flutter/material.dart';

class CustomSnackBar {
  static SnackBar create({required String text, required isError}) {
    return SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 20)),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: isError ? Colors.red : Colors.green,
    );
  }
}

import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message, bool isError) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 20)),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

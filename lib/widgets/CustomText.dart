import 'package:flutter/material.dart';

class CustomTextWidgets {
  static Text header(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Text formText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFB91635),
        fontSize: 25.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Text buttonText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Text commonStyling(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Text commonStyling2(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        color: Color(0xFF621d3c),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

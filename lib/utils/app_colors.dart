import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const MaterialColor primarySwatch = Colors.blue;
  static const Color primary = Color(0xFF2962FF); // Indigo/Blue accent

  // Surfaces
  static const Color appBarBackground = Colors.transparent;

  // Text
  static const Color textPrimary = Colors.black;
  static const Color textOnPrimary = Colors.white;

  // States
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  static const Color error = Colors.red;

  // Icons
  static const Color iconEdit = Colors.blue;
  static const Color iconDelete = Colors.red;
  static const Color appBarIcon = Colors.black;

  // Chips
  static const Color chipCompletedBg = success;
  static const Color chipPendingBg = warning;
  static const Color chipCompletedText = Colors.white;
  static const Color chipPendingText = Colors.black;
}

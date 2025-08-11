import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
);

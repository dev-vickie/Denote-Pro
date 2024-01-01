import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color.fromARGB(255, 21, 10, 121);
  static const Color secondaryColor = Color.fromARGB(255, 92, 119, 35);
  static const Color backgroundWhite = Color.fromARGB(255, 212, 221, 236);

  static final ThemeData lightTheme = ThemeData(
    // useMaterial3: false,
    fontFamily: 'Rubik',
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundWhite,
    primaryColorLight: secondaryColor,
  );
}

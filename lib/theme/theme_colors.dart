import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

   static const Color accentColor = Color.fromARGB(255, 15, 39, 87); // #0F2757
  static const Color primaryColor = Color.fromARGB(255, 38, 63, 155); // #263F9B
  static const Color secondaryColor =
      Color.fromARGB(255, 43, 72, 176); // #2B48B0
  static const Color blueLight = Color.fromARGB(255, 33, 189, 207); // #21BDCF
  static const greyColor = Color.fromARGB(255, 136, 142, 162); // #888EA2
  static const Color whiteColor = Color.fromARGB(255, 242, 242, 242); // #F2F2F2


  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Rubik',
    primaryColor: primaryColor,
    scaffoldBackgroundColor: whiteColor,
    primaryColorLight: secondaryColor,
  );
}

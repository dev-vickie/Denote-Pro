import 'package:denote_pro/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._();

  static TextStyle bold([double? fontSize]) => TextStyle(
        fontFamily: 'Rubik-Bold',
        fontSize: fontSize ?? 24,
        color: AppTheme.primaryColor,
      );
  static TextStyle normal([double? fontSize]) => TextStyle(
        fontFamily: 'Rubik',
        fontSize: fontSize ?? 16,
        color: AppTheme.primaryColor,
      );
}

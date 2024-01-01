import 'package:denote_pro/main.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  scaffoldKey.currentState!.showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

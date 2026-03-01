import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepPurple,
  );
}
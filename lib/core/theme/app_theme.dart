import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    cardColor: AppColors.surface,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    fontFamily: 'Montserrat',
  );
}

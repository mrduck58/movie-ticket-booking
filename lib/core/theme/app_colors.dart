import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const Color primary = Color(0xFFFF5B5B);
  static const Color onPrimary = Colors.white;

  //background / surface
  static const Color background= Colors.white;
  //static const Color onBackground = Colors.white;
  static const Color surface = Color.fromRGBO(222, 222, 209, 1);
  //static const Color onSurface = Colors.white;

  // default
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  //border
  static const Color border = Color(0x1F000000); 
  static const Color divider = Color(0xFF6B6B6B); 

  // Neutrals
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color.fromRGBO(222, 222, 209, 1);
  //static const Color textDisabled = Colors.white;

  // status
  static const Color success = Color.fromRGBO(89, 172, 119, 1);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color.fromRGBO(255, 195, 0, 1);

  // bottom navigator
  static const Color bottomNavBg = Colors.white;
  static const Color bottomNavActive = Color(0xFFFF5B5B);
  static const Color bottomNavInactive = Color.fromRGBO(125, 125, 125, 1);

  // rating 
  static const Color ratingStar = Color.fromRGBO(255, 212, 0, 1);

  // seat 
  static const Color seatAvailable = Colors.white;
  static const Color seatSelected = Color(0xFFFF5B5B);
  static const Color seatSold = Color.fromARGB(197, 199, 188, 1);

}
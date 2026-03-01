import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get titleLarge => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );
}
import 'package:flutter/material.dart';

import 'package:movie_ticket_booking/core/theme/app_colors.dart';

/// =======================================================
/// CHIP TAB NHỎ CHO SEARCH
/// - dùng để chuyển giữa:
///   + Rạp
///   + Phim
///
/// active = true:
/// - nền primary nhạt
/// - viền primary
/// - text primary
///
/// active = false:
/// - nền trắng
/// - viền border
/// - text secondary
/// =======================================================
class SearchTab extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;

  const SearchTab({
    super.key,
    required this.text,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary.withOpacity(0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: active ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: active ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../domain/entities/cinema.dart';

class CinemaTile extends StatelessWidget {
  const CinemaTile({
    required this.cinema,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  final Cinema cinema;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,

      visualDensity: const VisualDensity(vertical: 3),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pagePadding,
      ),

      leading: GestureDetector(
        onTap: onFavoriteToggle,
        child: Icon(
          isFavorite ? Icons.star : Icons.star_border,
          color: isFavorite
              ? AppColors.ratingStar
              : AppColors.textSecondary,
        ),
      ),

      title: Text(
        cinema.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColors.textPrimary,
        ),
      ),

      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import 'package:movie_ticket_booking/core/utils/formatters/money_formatter.dart';
import '../../../../domain/entities/combo.dart';

class ComboCard extends StatelessWidget {
  final Combo combo;
  final VoidCallback? onTap;

  const ComboCard({
    super.key,
    required this.combo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(combo.image, fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  combo.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  MoneyFormatter.vnd(combo.price),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

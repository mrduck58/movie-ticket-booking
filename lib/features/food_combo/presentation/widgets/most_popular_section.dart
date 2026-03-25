import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/widgets/combo_detail_sheet.dart';
import '../../../../domain/entities/combo.dart';
import 'combo_card.dart';

class MostPopularSection extends StatelessWidget {
  final List<Combo> combos;

  const MostPopularSection({super.key, required this.combos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Most Popular",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: combos.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 160,
                child: ComboCard(
                  combo: combos[index],
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: AppColors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder: (_) => ComboDetailSheet(combo: combos[index])
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

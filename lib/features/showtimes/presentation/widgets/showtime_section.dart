import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import 'package:movie_ticket_booking/core/utils/formatters/money_formatter.dart';
import 'package:movie_ticket_booking/features/showtimes/data/models/selected_showtime.dart';
import '../../../../domain/entities/showtime.dart';
import '../providers/showtime_providers.dart';

class ShowtimeSection extends ConsumerWidget {
  final Showtime showtime;

  const ShowtimeSection({super.key, required this.showtime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedShowtimeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  showtime.format,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(width: 15),

                Text(
                  '(${MoneyFormatter.vnd(showtime.price)})',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),

            Text(showtime.auditorium),
          ],
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: showtime.times.map((time) {
            final isSelected =
                selected?.showtime == showtime && selected?.time == time;

            return GestureDetector(
              onTap: () {
                ref.read(selectedShowtimeProvider.notifier).state =
                    SelectedShowtime(showtime: showtime, time: time);
              },

              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,

                  borderRadius: BorderRadius.circular(8),

                  border: Border.all(color: AppColors.primary),
                ),

                child: Text(
                  time,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

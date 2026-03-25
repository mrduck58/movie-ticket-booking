import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters/money_formatter.dart';
import '../../../../domain/entities/showtime_group.dart';
import '../../../../domain/entities/showtime.dart';
import '../providers/showtime_providers.dart';
import '../../data/models/selected_showtime.dart';

class ShowtimeSection extends ConsumerWidget {
  final ShowtimeGroup group;

  const ShowtimeSection({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedShowtimeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        /// HEADER (Standard / IMAX)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  group.ticketType,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(width: 15),

                Text(
                  '(${MoneyFormatter.vnd(group.price)})',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),

            /// room (lấy từ showtime đầu tiên)
            Text(group.showtimes.first.roomName),
          ],
        ),

        const SizedBox(height: 12),

        /// TIMES
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: group.showtimes.map((time) {
            final formatted = DateFormat.Hm().format(time.startTime);

            final isSelected = selected?.showtime.showtimeId == time.showtimeId;

            return GestureDetector(
              onTap: () {
                ref.read(selectedShowtimeProvider.notifier).state =
                    SelectedShowtime(showtime: time);
                ref
                    .read(bookingDraftProvider.notifier)
                    .setPackage(group.ticketType);
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
                  formatted,
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

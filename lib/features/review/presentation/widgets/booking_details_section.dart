import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import 'package:movie_ticket_booking/core/utils/formatters/date_formatter.dart';

class BookingDetailsSection extends StatelessWidget {
  final String cinema;
  final String roomName;
  final String package;
  final List<String> seats;
  final String date;
  final DateTime startTime;
  final double durationMin;

  const BookingDetailsSection({
    super.key,
    required this.cinema,
    required this.roomName,
    required this.package,
    required this.seats,
    required this.date,
    required this.startTime,
    required this.durationMin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        color: AppColors.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Booking Details",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),

          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 6),

          _row("Cinema", cinema),
          _row("Package", package),
          _row("Room", roomName),
          _row("Seat(s)", seats.join(", ")),
          _row("Date", date),
          _row("Hours", buildShowtimeRange(startTime, durationMin)),
        ],
      ),
    );
  }

  String buildShowtimeRange(DateTime startTime, double durationMin) {
    final endTime = startTime.add(Duration(minutes: durationMin.toInt()));

    return "${DateFormatter.time(startTime)} - ${DateFormatter.time(endTime)}";
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

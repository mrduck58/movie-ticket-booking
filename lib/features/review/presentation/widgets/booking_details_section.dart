import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';

class BookingDetailsSection extends StatelessWidget {
  final String cinema;
  final String auditorium;
  final List<String> seats;
  final String date;
  final String hours;
  final String durationMin;

  const BookingDetailsSection({
    super.key,
    required this.cinema,
    required this.auditorium,
    required this.seats,
    required this.date,
    required this.hours,
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
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),

          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 6),

          _row("Cinema", cinema),
          _row("Auditorium", auditorium),
          _row("Seat(s)", seats.join(", ")),
          _row("Date", date),
          _row("Hours", buildShowtimeRange(hours, durationMin)),
        ],
      ),
    );
  }

  String buildShowtimeRange(String startTime, String durationMin) {
    /// tách số khỏi "140 min"
    final duration = int.parse(durationMin.replaceAll(" min", ""));

    final parts = startTime.split(":");

    final start = DateTime(0, 1, 1, int.parse(parts[0]), int.parse(parts[1]));

    final end = start.add(Duration(minutes: duration));

    String format(DateTime t) {
      final h = t.hour.toString().padLeft(2, '0');
      final m = t.minute.toString().padLeft(2, '0');
      return "$h:$m";
    }

    return "${format(start)} - ${format(end)}";
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
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

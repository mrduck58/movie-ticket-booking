import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';

class BookingDetailsSection extends StatelessWidget {

  final String cinema;
  final String auditorium;
  final List<String> seats;
  final String date;
  final String hours;

  const BookingDetailsSection({
    super.key,
    required this.cinema,
    required this.auditorium,
    required this.seats,
    required this.date,
    required this.hours,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: AppColors.surface,
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "Booking Details",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          
          const SizedBox(height: 6),
          
          const Divider(),

          const SizedBox(height: 6),


          _row("Cinema", cinema),
          _row("Auditorium", auditorium),
          _row("Seat(s)", seats.join(", ")),
          _row("Date", date),
          _row("Hours", hours),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}
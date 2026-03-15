import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/features/ticket/domain/entities/ticket.dart';

class TicketCinemaInfo extends StatelessWidget {
  final Ticket ticket;

  const TicketCinemaInfo({super.key, required this.ticket});

  String formatFullDate(DateTime time) {
    return DateFormat('EEEE, MMM d, yyyy').format(time);
  }

  String formatTimeRange(DateTime start, DateTime end) {
    final startTime = DateFormat('HH:mm').format(start);
    final endTime = DateFormat('HH:mm').format(end);
    return "$startTime - $endTime";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          ticket.cinema,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),

        Text(
          "Standard - ${ticket.room}",
          style: const TextStyle(fontSize: 14),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
            const SizedBox(width: 4),

            Text(
              formatFullDate(ticket.startTime),
              style: const TextStyle(fontSize: 13),
            ),

            const SizedBox(width: 16),

            const Icon(Icons.access_time, size: 14, color: Colors.grey),
            const SizedBox(width: 4),

            Text(
              formatTimeRange(ticket.startTime, ticket.endTime),
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}
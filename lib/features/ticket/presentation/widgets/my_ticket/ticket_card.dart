import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/features/ticket/domain/entities/ticket.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/pages/ticket_detail.dart';
import 'ticket_remind_section.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  String formatDate(DateTime time) {
    return DateFormat('MMM d, yyyy').format(time);
  }

  String formatTimeRange(DateTime start, DateTime end) {
    final startTime = DateFormat('HH:mm').format(start);
    final endTime = DateFormat('HH:mm').format(end);
    return "$startTime - $endTime";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TicketDetailPage(ticket: ticket),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    ticket.poster,
                    height: 70,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        const Icon(Icons.movie, size: 50),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(formatDate(ticket.startTime)),

                          const SizedBox(width: 12),

                          const Icon(Icons.access_time,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(formatTimeRange(
                              ticket.startTime, ticket.endTime)),
                        ],
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.chevron_right),
              ],
            ),

            const SizedBox(height: 10),

            TicketRemindSection(ticket: ticket),
          ],
        ),
      ),
    );
  }
}
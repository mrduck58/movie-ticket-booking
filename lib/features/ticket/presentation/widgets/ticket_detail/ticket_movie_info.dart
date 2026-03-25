import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/ticket/domain/entities/ticket.dart';
import 'ticket_info_row.dart';

class TicketMovieInfo extends StatelessWidget {
  final Ticket ticket;

  const TicketMovieInfo({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              ticket.poster,
              height: 240,
              width: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 240,
                  width: 150,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image),
                );
              },
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 6),

                TicketInfoRow("Duration", "${ticket.duration} minutes"),
                // TicketInfoRow("Director", ticket.director),
                TicketInfoRow("Rating", ticket.rating.toString()),
                TicketInfoRow("Genre", ticket.genres.join(", ")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

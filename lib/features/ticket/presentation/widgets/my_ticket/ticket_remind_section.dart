import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/ticket/domain/entities/ticket.dart';

class TicketRemindSection extends StatefulWidget {
  final Ticket ticket;

  const TicketRemindSection({super.key, required this.ticket});

  @override
  State<TicketRemindSection> createState() => _TicketRemindSectionState();
}

class _TicketRemindSectionState extends State<TicketRemindSection> {
  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;

    if (ticket.isFinished) {
      return const SizedBox();
    }

    if (ticket.isShowing) {
      return const Row(
        children: [
          Text(
            "Now showing",
            style: TextStyle(
                color: Colors.orange, fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    return Row(
      children: [
        const Text(
          "Remind me 30 minutes earlier",
          style: TextStyle(fontSize: 13),
        ),
        const Spacer(),
        Switch(
          value: ticket.remind,
          onChanged: (v) {
            setState(() {
              ticket.remind = v;
            });
          },
        ),
      ],
    );
  }
}
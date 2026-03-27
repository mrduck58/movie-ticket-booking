import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/ticket/domain/entities/ticket.dart';

import '../widgets/ticket_detail/ticket_qr.dart';
import '../widgets/ticket_detail/ticket_cinema_info.dart';
import '../widgets/ticket_detail/ticket_seats.dart';
import '../widgets/ticket_detail/ticket_movie_info.dart';

class TicketDetailPage extends ConsumerWidget {
  final Ticket ticket;

  const TicketDetailPage({super.key, required this.ticket});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(title: const Text("Ticket"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            TicketQR(qrDatas: ticket.qrDatas),

            const SizedBox(height: 20),

            TicketCinemaInfo(ticket: ticket),

            const SizedBox(height: 20),

            TicketSeats(seats: ticket.seats),

            const SizedBox(height: 20),

            TicketMovieInfo(ticket: ticket),
          ],
        ),
      ),
    );
  }
}
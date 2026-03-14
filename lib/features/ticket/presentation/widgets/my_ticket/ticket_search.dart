import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/providers/ticket_providers.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/widgets/my_ticket/ticket_card.dart';
class TicketSearchPage extends ConsumerWidget {
  const TicketSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ticketControllerProvider);
    final tickets = state.filteredTickets;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(ticketControllerProvider.notifier).search('');
            Navigator.pop(context);
          },
        ),
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Search movie...",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            ref.read(ticketControllerProvider.notifier).search(value);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return TicketCard(ticket: tickets[index]);
        },
      ),
    );
  }
}
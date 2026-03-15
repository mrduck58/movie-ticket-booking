import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/providers/ticket_providers.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/widgets/my_ticket/ticket_card.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/widgets/my_ticket/ticket_header.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/widgets/my_ticket/ticket_tabs.dart';

class MyTicketsPage extends ConsumerStatefulWidget {
  const MyTicketsPage({super.key});

  @override
  ConsumerState<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends ConsumerState<MyTicketsPage> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ticketControllerProvider);
    final tickets = state.filteredTickets;
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: Column(
          children: [
            const TicketHeader(),

            TicketTabs(
              tabIndex: tabIndex,
              onChanged: (index) {
                setState(() {
                  tabIndex = index;
                });
              },
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];

                  if (tabIndex == 0 && ticket.isFinished) {
                    return const SizedBox();
                  }

                  if (tabIndex == 1 && !ticket.isFinished) {
                    return const SizedBox();
                  }

                  return TicketCard(ticket: ticket);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

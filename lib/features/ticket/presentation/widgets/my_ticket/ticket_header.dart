import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/home/presentation/pages/home_page.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/widgets/my_ticket/ticket_search.dart';

class TicketHeader extends ConsumerWidget {
  const TicketHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.push('/');
            },
          ),

          const Expanded(
            child: Center(
              child: Text(
                "My Tickets",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TicketSearchPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/features/ticket/data/repositories/ticket_repository_impl.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/providers/ticket_state.dart';

class TicketController extends StateNotifier<TicketState> {
  final TicketRepositoryImpl repo;

  TicketController(this.repo) : super(TicketState(tickets: [])) {
    loadTickets();
  }

  Future<void> loadTickets() async {
    final tickets = await repo.getTickets();
    state = state.copyWith(tickets: tickets);
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
  }
  
}
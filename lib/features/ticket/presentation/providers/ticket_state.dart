import 'package:movie_ticket_booking/features/ticket/domain/entities/ticket.dart';
class TicketState {
  final List<Ticket> tickets;
  final String searchQuery;

  TicketState({
    required this.tickets,
    this.searchQuery = "",
  });

  TicketState copyWith({
    List<Ticket>? tickets,
    String? searchQuery,
  }) {
    return TicketState(
      tickets: tickets ?? this.tickets,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Ticket> get filteredTickets {
    if (searchQuery.isEmpty) return tickets;

    return tickets
        .where((t) =>
            t.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
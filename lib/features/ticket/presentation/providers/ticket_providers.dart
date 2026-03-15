import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/features/ticket/data/datasources/ticket_datasource.dart';
import 'package:movie_ticket_booking/features/ticket/data/repositories/ticket_repository_impl.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/providers/ticket_controller.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/providers/ticket_state.dart';

final ticketRepositoryProvider = Provider((ref) {
  return TicketRepositoryImpl(TicketDatasource());
});

final ticketControllerProvider =
    StateNotifierProvider<TicketController, TicketState>((ref) {
  final repo = ref.read(ticketRepositoryProvider);
  return TicketController(repo);
});
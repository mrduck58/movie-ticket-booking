import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../datasources/ticket_datasource.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketDatasource datasource;

  TicketRepositoryImpl(this.datasource);

  @override
  Future<List<Ticket>> getTickets() async {
    return await datasource.getTickets();
  }
}
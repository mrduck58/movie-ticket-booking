import '../../../../domain/entities/seat.dart';
import '../../../../domain/repositories/seat_repository.dart';
import '../datasources/seat_mock_datasource.dart';

class SeatRepositoryImpl implements SeatRepository {

  final SeatMockDatasource datasource;

  SeatRepositoryImpl(this.datasource);

  @override
  Future<List<Seat>> getSeats() async {
    final models = await datasource.getSeats();
    return models.map((e) => e.toEntity()).toList();
  }
}
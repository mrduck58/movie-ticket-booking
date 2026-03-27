import '../../data/models/seat_map_model.dart';
import '../../../../domain/repositories/seat_repository.dart';
import '../datasources/seat_api_datasource.dart';

class SeatRepositoryImpl implements SeatRepository {

  final SeatApiDatasource datasource;

  SeatRepositoryImpl(this.datasource);

  @override
  Future<SeatMapModel> getSeats(String showtimeId) {
    return datasource.getSeats(showtimeId);
  }

  @override
  Future<void> lockSeats(String showtimeId, List<String> seatIds) {
    return datasource.lockSeats(showtimeId, seatIds);
  }
}
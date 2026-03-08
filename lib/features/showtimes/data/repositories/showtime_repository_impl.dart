import '../../../../domain/entities/showtime.dart';
import '../../../../domain/repositories/showtime_repository.dart';
import '../datasources/showtime_mock_datasource.dart';

class ShowtimeRepositoryImpl implements ShowtimeRepository {
  final ShowtimeMockDatasource datasource;

  ShowtimeRepositoryImpl(this.datasource);

  @override
  Future<List<Showtime>> getShowtimes(String cinemaId) async {
    final models = await datasource.getShowtimes(cinemaId);
    return models.map((e) => e.toEntity()).toList();
  }
}
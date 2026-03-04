import '../datasources/showtime_mock_datasource.dart';
import '../models/showtime_model.dart';

abstract class ShowtimeRepository {
  Future<List<ShowtimeModel>> getShowtimes();
}

class ShowtimeRepositoryImpl implements ShowtimeRepository {
  final ShowtimeMockDataSource dataSource;
  ShowtimeRepositoryImpl(this.dataSource);

  @override
  Future<List<ShowtimeModel>> getShowtimes() => dataSource.fetchShowtimes();
}
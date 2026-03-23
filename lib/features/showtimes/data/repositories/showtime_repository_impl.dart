import '../../../../domain/entities/showtime_group.dart';
import '../../../../domain/repositories/showtime_repository.dart';
import '../datasources/showtime_api_datasource.dart';

class ShowtimeRepositoryImpl implements ShowtimeRepository {
  final ShowtimeApiDatasource datasource;

  ShowtimeRepositoryImpl(this.datasource);

  @override
  Future<List<ShowtimeGroup>> getShowtimes(
    String movieId,
    String cinemaId,
    DateTime date,
  ) async {
    final models =
        await datasource.getShowtimes(movieId, cinemaId, date);

    return models.map((m) => m.toEntity()).toList();
  }
}
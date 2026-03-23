import '../entities/showtime_group.dart';

abstract class ShowtimeRepository {
  Future<List<ShowtimeGroup>> getShowtimes(
    String movieId,
    String cinemaId,
    DateTime date,
  );
}

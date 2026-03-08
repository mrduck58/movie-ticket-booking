import '../entities/showtime.dart';

abstract class ShowtimeRepository {
  Future<List<Showtime>> getShowtimes(String cinemaId);
}
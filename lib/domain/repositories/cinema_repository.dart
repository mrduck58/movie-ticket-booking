import '../entities/cinema.dart';

abstract class CinemaRepository {
  Future<List<Cinema>> getCinemasByMovie(String movieId);
  Future<Cinema> getCinemaById(String cinemaId);
}
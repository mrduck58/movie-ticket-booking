import 'package:movie_ticket_booking/domain/entities/movie.dart';

import '../entities/cinema.dart';

abstract class CinemaRepository {
  Future<List<Cinema>> getCinemasByMovie(String movieId);
  Future<Cinema> getCinemaById(String cinemaId);
  Future<List<Cinema>> getCinemas();
  Future<List<Movie>> getMoviesByCinema(String cinemaId);
}
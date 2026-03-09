import '../entities/cinema.dart';
import '../entities/movie.dart';

abstract class SearchRepository {
  Future<List<Cinema>> getCinemas();
  Future<List<Movie>> getMovies();
}
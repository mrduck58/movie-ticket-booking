import '../entities/movie.dart';

abstract class WatchlistRepository {
  Future<List<Movie>> getWatchlist();
  Future<List<Movie>> getWatched();
}
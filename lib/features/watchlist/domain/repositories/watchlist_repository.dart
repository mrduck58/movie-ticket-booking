import '../entities/movie.dart';

abstract class WatchlistRepository {
  Future<List<Movie>> getAllByUser();
  Future<List<Movie>> getWatchlist();
  Future<List<Movie>> getWatched();

  Future<void> addItem({
    required String movieId,
    required MovieListType type,
  });

  Future<void> removeItem({
    required String movieId,
  });

  Future<void> moveItem({
    required String movieId,
    required MovieListType toType,
  });
}
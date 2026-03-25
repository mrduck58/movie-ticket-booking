import '../../domain/entities/movie.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/watchlist_remote_data_source.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource remote;

  WatchlistRepositoryImpl(this.remote);

  @override
  Future<List<Movie>> getAllByUser() async {
    return await remote.getAll();
  }

  @override
  Future<List<Movie>> getWatchlist() async {
    final all = await remote.getAll();
    return all.where((e) => e.isInWatchlist).toList();
  }

  @override
  Future<List<Movie>> getWatched() async {
    final all = await remote.getAll();
    return all.where((e) => e.isWatched).toList();
  }

  @override
  Future<void> addItem({
    required String movieId,
    required MovieListType type,
  }) async {
    await remote.addItem(
      movieId: movieId,
      type: type,
    );
  }

  @override
  Future<void> removeItem({
    required String movieId,
  }) async {
    await remote.removeItem(
      movieId: movieId,
    );
  }

  @override
  Future<void> moveItem({
    required String movieId,
    required MovieListType toType,
  }) async {
    await remote.removeItem(
      movieId: movieId,
    );

    await remote.addItem(
      movieId: movieId,
      type: toType,
    );
  }
}
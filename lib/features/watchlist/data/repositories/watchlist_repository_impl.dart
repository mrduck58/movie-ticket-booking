import '../../../../domain/entities/movie.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/watchlist_local_datasource.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource local;
  WatchlistRepositoryImpl(this.local);

 
  @override
  Future<List<Movie>> getWatchlist() async {
    final list = await local.getWatchlist();
    return List<Movie>.from(list);
  }

  @override
  Future<List<Movie>> getWatched() async {
    final list = await local.getWatched();
    return List<Movie>.from(list);
  }
}
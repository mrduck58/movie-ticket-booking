import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/watchlist_repository.dart';
import 'watchlist_providers.dart';
import 'watchlist_state.dart';

class WatchlistController extends AsyncNotifier<WatchlistState> {
  late WatchlistRepository _repo;

  @override
  Future<WatchlistState> build() async {
    _repo = ref.read(watchlistRepositoryProvider);

    final watchlist = await _repo.getWatchlist();
    final watched = await _repo.getWatched();

    return WatchlistState(
      watchlist: watchlist,
      watched: watched,
    );
  }

  Future<void> refreshData() async {
    state = const AsyncLoading();
    state = AsyncData(await build());
  }

  Future<void> addToWatchlist(String movieId) async {
    await _repo.addItem(
      movieId: movieId,
      type: MovieListType.favorite,
    );
    await refreshData();
  }

  Future<void> addToWatched(String movieId) async {
    await _repo.addItem(
      movieId: movieId,
      type: MovieListType.watched,
    );
    await refreshData();
  }

  Future<void> removeItem(String movieId) async {
    await _repo.removeItem(
      movieId: movieId,
    );
    await refreshData();
  }

  Future<void> markAsWatched(Movie movie) async {
    await _repo.moveItem(
      movieId: movie.id,
      toType: MovieListType.watched,
    );
    await refreshData();
  }

  Future<void> moveToWatchlist(Movie movie) async {
    await _repo.moveItem(
      movieId: movie.id,
      toType: MovieListType.favorite,
    );
    await refreshData();
  }
}
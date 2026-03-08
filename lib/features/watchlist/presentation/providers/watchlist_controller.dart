import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/watchlist_repository.dart';
import 'watchlist_providers.dart';
import 'watchlist_state.dart';

class WatchlistController extends AsyncNotifier<WatchlistState> {
  late final WatchlistRepository _repo;

  @override
  Future<WatchlistState> build() async {
    _repo = ref.read(watchlistRepositoryProvider);
    final wl = await _repo.getWatchlist();
    final wt = await _repo.getWatched();
    return WatchlistState(watchlist: wl, watched: wt);
  }
}
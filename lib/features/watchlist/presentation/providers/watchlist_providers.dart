import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/watchlist_local_datasource.dart';
import '../../data/repositories/watchlist_repository_impl.dart';
import '../../domain/repositories/watchlist_repository.dart';
import 'watchlist_controller.dart';
import 'watchlist_state.dart';

final watchlistLocalDataSourceProvider =
    Provider<WatchlistLocalDataSource>((ref) => WatchlistLocalDataSource());

final watchlistRepositoryProvider = Provider<WatchlistRepository>((ref) {
  return WatchlistRepositoryImpl(ref.read(watchlistLocalDataSourceProvider));
});

final watchlistControllerProvider =
    AsyncNotifierProvider<WatchlistController, WatchlistState>(
  WatchlistController.new,
);
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/watchlist_remote_data_source.dart';
import '../../data/repositories/watchlist_repository_impl.dart';
import '../../domain/repositories/watchlist_repository.dart';
import 'watchlist_controller.dart';
import 'watchlist_state.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final watchlistRemoteDataSourceProvider =
    Provider<WatchlistRemoteDataSource>((ref) {
  return WatchlistRemoteDataSource(
    ref.read(httpClientProvider),
  );
});

final watchlistRepositoryProvider = Provider<WatchlistRepository>((ref) {
  return WatchlistRepositoryImpl(
    ref.read(watchlistRemoteDataSourceProvider),
  );
});

final watchlistControllerProvider =
    AsyncNotifierProvider<WatchlistController, WatchlistState>(
  WatchlistController.new,
);
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/movie_mock_datasource.dart';
import '../../data/repositories/movie_repository.dart';
import '../../data/models/movie_model.dart';

final movieDataSourceProvider = Provider<MovieMockDataSource>((ref) {
    return MovieMockDataSource();
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
    final ds = ref.watch(movieDataSourceProvider);
    return MovieRepositoryImpl(ds);
});

final movieProvider = FutureProvider<List<MovieModel>>((ref) async {
    final repo = ref.watch(movieRepositoryProvider);
    return repo.getMovies();
});
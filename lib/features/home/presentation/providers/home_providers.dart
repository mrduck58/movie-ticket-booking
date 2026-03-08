import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/movie_mock_datasource.dart';
import '../../data/models/movie_model.dart';
import '../../data/repositories/movie_repository.dart';

final movieDatasourceProvider = Provider<MovieMockDatasource>((ref) {
  return MovieMockDatasource();
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository(ref.watch(movieDatasourceProvider));
});

final movieProvider = FutureProvider<List<MovieModel>>((ref) async {

  final repo = ref.watch(movieRepositoryProvider);

  return repo.getMovies();
});
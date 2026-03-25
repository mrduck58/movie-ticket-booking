import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/movie_api_datasource.dart';
import '../../data/models/movie_model.dart';
import '../../data/repositories/movie_repository.dart';

final movieDatasourceProvider = Provider<MovieApiDatasource>((ref) {
  return MovieApiDatasource();
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository(ref.watch(movieDatasourceProvider));
});
final movieDetailProvider =
    FutureProvider.family<MovieModel, String>((ref, id) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.getMovieById(id);
});
final movieProvider = FutureProvider<List<MovieModel>>((ref) async {

  final repo = ref.watch(movieRepositoryProvider);

  return repo.getMovies();
});
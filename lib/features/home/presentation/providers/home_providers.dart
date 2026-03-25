import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/movie_api_datasource.dart';
import '../../data/models/movie_model.dart';
import '../../data/repositories/movie_repository.dart';

import '../../data/datasources/user_api_datasource.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model.dart';

// ================= MOVIE =================

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


// ================= USER  =================

// datasource
final userDatasourceProvider = Provider<UserApiDatasource>((ref) {
  return UserApiDatasource();
});

// repository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(userDatasourceProvider));
});

// user provider (dùng cho header)
final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final repo = ref.watch(userRepositoryProvider);
  return repo.getCurrentUser();
});
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/search_remote_datasource.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/search_repository.dart';
import 'search_controller.dart';
import 'search_state.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final searchDatasourceProvider = Provider<SearchRemoteDatasource>((ref) {
  return SearchRemoteDatasource(ref.read(httpClientProvider));
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepositoryImpl(ref.read(searchDatasourceProvider));
});

final searchControllerProvider =
    AsyncNotifierProvider<SearchController, SearchState>(
  SearchController.new,
);
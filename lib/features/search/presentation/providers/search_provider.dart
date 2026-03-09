import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/search_mock_datasource.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../domain/repositories/search_repository.dart';

import 'search_controller.dart';
import 'search_state.dart';

final searchDatasourceProvider =
    Provider((ref) => SearchMockDatasource());

final searchRepositoryProvider =
    Provider<SearchRepository>((ref) {

  return SearchRepositoryImpl(
    ref.read(searchDatasourceProvider),
  );

});

final searchControllerProvider =
    AsyncNotifierProvider<SearchController, SearchState>(
  SearchController.new,
);
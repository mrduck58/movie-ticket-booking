import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/search_repository.dart';
import 'search_provider.dart';
import 'search_state.dart';

class SearchController extends AsyncNotifier<SearchState> {
  late final SearchRepository _repo;

  @override
  Future<SearchState> build() async {
    _repo = ref.read(searchRepositoryProvider);
    return const SearchState.empty();
  }

  Future<void> search(String keyword) async {
    final trimmed = keyword.trim();

    if (trimmed.isEmpty) {
      state = const AsyncData(SearchState.empty());
      return;
    }

    state = const AsyncLoading();

    try {
      final result = await _repo.search(trimmed);

      state = AsyncData(
        SearchState(
          keyword: trimmed,
          cinemas: result.cinemas,
          movies: result.movies,
        ),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void clear() {
    state = const AsyncData(SearchState.empty());
  }
}
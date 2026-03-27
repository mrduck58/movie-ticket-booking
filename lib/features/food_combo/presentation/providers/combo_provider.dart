import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/features/food_combo/data/datasources/combo_api_datasource.dart';

import '../../data/repositories/combo_repository_impl.dart';
import '../../../../domain/entities/combo.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://localhost:7132/api',
    ),
  );
});

final comboDatasourceProvider = Provider(
  (ref) => ComboApiDatasource(ref.watch(dioProvider)),
);

final comboRepositoryProvider = Provider(
  (ref) => ComboRepositoryImpl(ref.watch(comboDatasourceProvider)),
);

final combosProvider = FutureProvider<List<Combo>>((ref) async {
  final repo = ref.watch(comboRepositoryProvider);
  return repo.getCombos();
});

final selectedCombosProvider =
    StateNotifierProvider<SelectedCombosNotifier, Map<String, int>>(
  (ref) => SelectedCombosNotifier(),
);

class SelectedCombosNotifier extends StateNotifier<Map<String, int>> {
  SelectedCombosNotifier() : super({});

  void add(String id) {
    state = {
      ...state,
      id: (state[id] ?? 0) + 1,
    };
  }

  void remove(String id) {
    if (!state.containsKey(id)) return;

    final qty = state[id]! - 1;

    if (qty <= 0) {
      final newState = {...state}..remove(id);
      state = newState;
    } else {
      state = {...state, id: qty};
    }
  }

  void clear() {
    state = {};
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/repositories/combo_repository_impl.dart';
import '../../../../domain/entities/combo.dart';

final comboRepositoryProvider = Provider(
  (ref) => ComboRepositoryImpl(),
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
}
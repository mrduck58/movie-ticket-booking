import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:state_notifier/state_notifier.dart';
import '../../../../domain/entities/cart_combo.dart';

class CartComboNotifier extends StateNotifier<List<CartCombo>> {
  CartComboNotifier() : super([]);

  void addCombo(String comboId) {
    final existIndex =
        state.indexWhere((element) => element.comboId == comboId);

    if (existIndex >= 0) {
      final updated = [...state];

      updated[existIndex] = CartCombo(
        cartComboId: updated[existIndex].cartComboId,
        comboId: comboId,
        quantity: updated[existIndex].quantity + 1,
      );

      state = updated;
    } else {
      state = [
        ...state,
        CartCombo(
          cartComboId: DateTime.now().millisecondsSinceEpoch.toString(),
          comboId: comboId,
          quantity: 1,
        )
      ];
    }
  }
}

final cartComboProvider =
    StateNotifierProvider<CartComboNotifier, List<CartCombo>>(
  (ref) => CartComboNotifier(),
);
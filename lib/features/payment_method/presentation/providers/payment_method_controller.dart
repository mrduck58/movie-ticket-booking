import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_method_repository.dart';
import 'payment_method_providers.dart';
import 'payment_method_state.dart';

class PaymentMethodController extends AsyncNotifier<PaymentMethodState> {
  late final PaymentMethodRepository _repo;

  @override
  Future<PaymentMethodState> build() async {
    _repo = ref.read(paymentMethodRepositoryProvider);
    final methods = await _repo.getMethods();
    final selectedId = await _repo.getSelectedId();
    return PaymentMethodState(methods: methods, selectedId: selectedId);
  }

  Future<void> select(String id) async {
    await _repo.setSelectedId(id);
    final cur = state.value;
    if (cur != null) {
      state = AsyncData(cur.copyWith(selectedId: id));
    }
  }

  Future<void> addNewMockCard() async {
    // demo add card
    final newMethod = PaymentMethod(
      id: 'pm_new_${DateTime.now().millisecondsSinceEpoch}',
      type: PaymentType.visa,
      title: '•••• •••• •••• 9999',
    );
    await _repo.addMethod(newMethod);

    // reload list
    final methods = await _repo.getMethods();
    final selectedId = await _repo.getSelectedId();
    state = AsyncData(PaymentMethodState(methods: methods, selectedId: selectedId));
  }
}
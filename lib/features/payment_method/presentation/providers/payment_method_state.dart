import '../../domain/entities/payment_method.dart';

class PaymentMethodState {
  final List<PaymentMethod> methods;
  final String? selectedId;

  const PaymentMethodState({
    required this.methods,
    required this.selectedId,
  });

  PaymentMethodState copyWith({
    List<PaymentMethod>? methods,
    String? selectedId,
  }) {
    return PaymentMethodState(
      methods: methods ?? this.methods,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PaymentType { paypal, googlePay, applePay, card }

class PaymentMethodItem {
  final String id;
  final PaymentType type;
  final String title;
  final String? masked;
  final bool isCard;

  const PaymentMethodItem({
    required this.id,
    required this.type,
    required this.title,
    this.masked,
    this.isCard = false,
  });
}

final paymentMethodsProvider = Provider<List<PaymentMethodItem>>((ref) {
  return const [
    PaymentMethodItem(id: 'pp', type: PaymentType.paypal, title: 'PayPal'),
    PaymentMethodItem(id: 'gp', type: PaymentType.googlePay, title: 'Google Pay'),
    PaymentMethodItem(id: 'ap', type: PaymentType.applePay, title: 'Apple Pay'),
    PaymentMethodItem(id: 'mc_4679', type: PaymentType.card, title: 'Mastercard', masked: '•••• •••• •••• 4679', isCard: true),
    PaymentMethodItem(id: 'visa_5567', type: PaymentType.card, title: 'VISA', masked: '•••• •••• •••• 5567', isCard: true),
  ];
});

class SelectedPaymentId extends Notifier<String?> {
  @override
  String? build() => 'mc_4679';

  void select(String id) => state = id;
}

final selectedPaymentIdProvider =
    NotifierProvider<SelectedPaymentId, String?>(SelectedPaymentId.new);
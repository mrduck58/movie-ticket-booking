enum PaymentType { paypal, googlePay, applePay, mastercard, visa }

class PaymentMethod {
  final String id;
  final PaymentType type;
  final String title;

  const PaymentMethod({
    required this.id,
    required this.type,
    required this.title,
  });
}
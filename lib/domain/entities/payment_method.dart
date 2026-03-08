class PaymentMethod {
  final String id;
  final String name;
  final String icon;
  final String? lastDigits;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    this.lastDigits,
  });
}
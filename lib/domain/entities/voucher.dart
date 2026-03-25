class Voucher {
  final String id;
  final String code;
  final String title;
  final double discountValue;
  final String description;
  final String type;
  final DateTime expiryDate;
  final String status;

  Voucher({
    required this.id,
    required this.code,
    required this.title,
    required this.discountValue,
    required this.description,
    required this.type,
    required this.expiryDate,
    required this.status,
  });
}
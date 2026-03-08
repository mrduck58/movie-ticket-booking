import '../../../../domain/entities/payment_method.dart';

class PaymentMethodModel {

  final String id;
  final String name;
  final String icon;
  final String? lastDigits;

  PaymentMethodModel({
    required this.id,
    required this.name,
    required this.icon,
    this.lastDigits,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      lastDigits: json['last_digits'],
    );
  }

  PaymentMethod toEntity() {
    return PaymentMethod(
      id: id,
      name: name,
      icon: icon,
      lastDigits: lastDigits,
    );
  }
}
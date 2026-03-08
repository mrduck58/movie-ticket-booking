import '../../domain/entities/payment_method.dart';

class PaymentMethodModel extends PaymentMethod {
  PaymentMethodModel({
    required super.id,
    required super.type,
    required super.title,
  });

  static PaymentType _parseType(String raw) {
    switch (raw) {
      case 'paypal':
        return PaymentType.paypal;
      case 'googlePay':
        return PaymentType.googlePay;
      case 'applePay':
        return PaymentType.applePay;
      case 'mastercard':
        return PaymentType.mastercard;
      case 'visa':
        return PaymentType.visa;
      default:
        return PaymentType.visa; // fallback
    }
  }

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'].toString(),
      type: _parseType(json['type'].toString()),
      title: json['title'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'title': title,
      };
}
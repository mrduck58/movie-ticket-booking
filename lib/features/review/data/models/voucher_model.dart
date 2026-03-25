import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/voucher.dart';

class VoucherModel extends Voucher {
  VoucherModel({
    required super.id,
    required super.code,
    required super.description,
    required super.title,
    required super.discountValue,
    required super.type,
    required super.expiryDate,
    required super.status,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json["voucherId"],
      title: json["title"],
      code: json["code"],
      description: json["description"],
      discountValue: json["discountValue"],
      type: json["type"],
      expiryDate: DateTime.parse(json["expiredDate"]),
      status: json["status"],
    );
  }
}

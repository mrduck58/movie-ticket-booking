import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/voucher.dart';

class VoucherModel extends Voucher {
  const VoucherModel({
    required super.code,
    required super.title,
    required super.discount,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      code: json["code"],
      title: json["title"],
      discount: json["discount"],
    );
  }
}
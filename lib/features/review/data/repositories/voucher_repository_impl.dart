import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:movie_ticket_booking/domain/entities/voucher.dart';
import 'package:movie_ticket_booking/domain/repositories/voucher_repository.dart';
import 'package:movie_ticket_booking/features/review/data/models/voucher_model.dart';

class VoucherRepositoryImpl implements VoucherRepository {
  @override
  Future<List<Voucher>> getVouchers() async {
    final jsonString = await rootBundle.loadString("assets/mock/vouchers.json");

    final List data = json.decode(jsonString);

    return data.map((e) => VoucherModel.fromJson(e)).toList();
  }
}

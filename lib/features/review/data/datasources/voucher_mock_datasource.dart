import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/voucher_model.dart';

class VoucherMockDatasource {

  Future<List<VoucherModel>> getVouchers() async {

    final jsonString =
        await rootBundle.loadString("assets/mock/vouchers.json");

    final List data = json.decode(jsonString);

    return data.map((e) => VoucherModel.fromJson(e)).toList();
  }
}
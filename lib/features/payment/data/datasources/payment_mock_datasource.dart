import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/payment_method_model.dart';

abstract class PaymentMockDatasource {
  Future<List<PaymentMethodModel>> getPaymentMethods();
}

class PaymentMockDatasourceImpl implements PaymentMockDatasource {

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {

    final raw = await rootBundle.loadString(
      'assets/mock/payments.json',
    );

    final list = jsonDecode(raw) as List;

    return list
        .map((e) => PaymentMethodModel.fromJson(e))
        .toList();
  }
}
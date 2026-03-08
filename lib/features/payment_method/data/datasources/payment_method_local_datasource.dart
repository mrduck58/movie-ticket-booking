import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/payment_method_model.dart';

class PaymentMethodLocalDataSource {
  Future<Map<String, dynamic>> _load() async {
    final raw =
        await rootBundle.loadString('assets/mock/payment_methods.json');
    return json.decode(raw) as Map<String, dynamic>;
  }

  Future<List<PaymentMethodModel>> getMethods() async {
    final data = await _load();
    final list = (data['methods'] as List? ?? const []);
    return list.map((e) => PaymentMethodModel.fromJson(e)).toList();
  }

  Future<String?> getSelectedId() async {
    final data = await _load();
    return data['selectedId']?.toString();
  }

  // Mock-only: không ghi file assets được -> simulate in-memory
  String? _selectedIdCache;
  final List<PaymentMethodModel> _addedCache = [];

  Future<void> setSelectedId(String id) async {
    _selectedIdCache = id;
  }

  Future<void> addMethod(PaymentMethodModel method) async {
    _addedCache.add(method);
  }

  // combine initial + added
  Future<List<PaymentMethodModel>> getMethodsWithCache() async {
    final base = await getMethods();
    return [...base, ..._addedCache];
  }

  Future<String?> getSelectedIdWithCache() async {
    return _selectedIdCache ?? await getSelectedId();
  }
}
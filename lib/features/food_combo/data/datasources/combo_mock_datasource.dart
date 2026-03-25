import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/combo_model.dart';

class ComboMockDataSource {
  Future<List<ComboModel>> fetchCombos() async {
    final raw = await rootBundle.loadString('assets/mock/combos.json');
    final decoded = jsonDecode(raw) as List;
    return decoded.map((e) => ComboModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
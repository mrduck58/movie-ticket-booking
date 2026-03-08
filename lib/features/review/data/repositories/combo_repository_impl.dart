import 'dart:convert';
import 'package:flutter/services.dart';

import '../../../../domain/entities/combo.dart';
import '../../../../domain/repositories/combo_repository.dart';
import '../models/combo_model.dart';

class ComboRepositoryImpl implements ComboRepository {
  @override
  Future<List<Combo>> getCombos() async {
    final jsonString =
        await rootBundle.loadString('assets/mock/combos.json');

    final List data = json.decode(jsonString);

    return data
        .map((e) => ComboModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
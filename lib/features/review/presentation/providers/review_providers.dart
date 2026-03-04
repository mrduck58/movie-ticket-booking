import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/combo_mock_datasource.dart';
import '../../data/models/combo_model.dart';

final comboDataSourceProvider = Provider((ref) => ComboMockDataSource());

final combosProvider = FutureProvider<List<ComboModel>>((ref) async {
  return ref.watch(comboDataSourceProvider).fetchCombos();
});
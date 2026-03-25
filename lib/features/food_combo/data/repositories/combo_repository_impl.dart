import 'package:movie_ticket_booking/domain/entities/combo.dart';
import 'package:movie_ticket_booking/domain/repositories/combo_repository.dart';

import '../datasources/combo_api_datasource.dart';

class ComboRepositoryImpl implements ComboRepository {
  final ComboApiDatasource datasource;

  ComboRepositoryImpl(this.datasource);

  @override
  Future<List<Combo>> getCombos() async {
    return datasource.fetchCombos();
  }
}
import 'package:dio/dio.dart';
import '../models/combo_model.dart';

class ComboApiDatasource {
  final Dio dio;

  ComboApiDatasource(this.dio);

  Future<List<ComboModel>> fetchCombos() async {
    final response = await dio.get('/combos');

    final List data = response.data;

    return data
        .map((e) => ComboModel.fromJson(e))
        .toList();
  }
}
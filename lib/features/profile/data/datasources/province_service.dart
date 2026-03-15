import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking/features/profile/data/models/province_model.dart';

class ProvinceService {

  Future<List<Province>> fetchProvinces() async {

    final response = await http.get(
      Uri.parse("https://provinces.open-api.vn/api/p/"),
    );

    if (response.statusCode == 200) {

      final List data = json.decode(response.body);

      return data
          .map((e) => Province.fromJson(e))
          .toList();

    } else {
      throw Exception("Failed to load provinces");
    }
  }
}
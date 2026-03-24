import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/search_result_model.dart';

class SearchRemoteDatasource {
  final http.Client client;

  SearchRemoteDatasource(this.client);

  static const String baseUrl = 'https://localhost:7132/api/search';
  // Android emulator thì đổi thành:
  // static const String baseUrl = 'https://10.0.2.2:7132/api/search';

  Future<SearchResultModel> search(String keyword) async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        'keyword': keyword,
      },
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      return SearchResultModel.fromJson(decoded);
    }

    if (response.statusCode == 404) {
      return const SearchResultModel(
        cinemas: [],
        movies: [],
      );
    }

    if (response.statusCode == 400) {
      throw Exception('Keyword is required');
    }

    throw Exception('Search failed: ${response.body}');
  }
}
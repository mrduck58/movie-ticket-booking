import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/movie.dart';
import '../models/movie_model.dart';

class WatchlistRemoteDataSource {
  final http.Client client;

  WatchlistRemoteDataSource(this.client);

  static const String baseUrl = 'https://localhost:7132/api/watchlist';

  Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print("WATCHLIST TOKEN: $token");

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty)
        'Authorization': 'Bearer $token',
    };
  }

  Future<List<MovieModel>> getAll() async {
    final response = await client.get(
      Uri.parse(baseUrl),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded
            .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      throw Exception('Invalid response format');
    }

    if (response.statusCode == 404) {
      return [];
    }

    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    }

    throw Exception('Failed to fetch watchlist: ${response.body}');
  }

  Future<void> addItem({
    required String movieId,
    required MovieListType type,
  }) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: await _headers(),
      body: jsonEncode({
        'movieId': movieId,
        'type': type.apiValue,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add item: ${response.body}');
    }
  }

  Future<void> removeItem({
    required String movieId,
  }) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/$movieId'),
      headers: await _headers(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove item: ${response.body}');
    }
  }
}
import 'dart:convert';
import 'package:movie_ticket_booking/features/post/data/models/create_post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';
import 'package:http/http.dart' as http;

class PostRemoteDataSource {
  final String baseUrl = "https://localhost:7132/api/blogpost";
  Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print("WATCHLIST TOKEN: $token");

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>?> getUserFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) return null;

    // Token format: header.payload.signature
    final parts = token.split('.');
    if (parts.length != 3) return null;

    final payload = parts[1];

    // Base64Url decode (có padding)
    var normalized = base64Url.normalize(payload);
    final decodedBytes = base64Url.decode(normalized);
    final decodedString = utf8.decode(decodedBytes);

    // Chuyển payload thành JSON
    final payloadMap = json.decode(decodedString);
    return payloadMap; // chứa id, name, avatar...
  }

  

  Future<List<PostModel>> getPosts() async {
    final response = await http.get(
      Uri.parse("$baseUrl/posts"),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return (data as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }

  Future<Map<String, dynamic>> toggleLike(String id) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$id/like"),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to like post");
    }
  }

  Future<void> createPost(CreatePostModel model) async {
    final response = await http.post(
      Uri.parse(baseUrl), // ⚠️ sửa đúng route backend
      headers: await _headers(),
      body: json.encode(model.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to create post");
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_comment_model.dart';

class PostCommentRemoteDatasource {
  final String baseUrl = "https://localhost:7132/api"; // sửa lại
  Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print("WATCHLIST TOKEN: $token");

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  /// GET comments theo postId
  Future<List<PostCommentModel>> getComments(String postId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/blogpost/$postId/comments'),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      return data.map((e) => PostCommentModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<void> addComment({
    required String postId,
    required String content,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/blogpost/$postId/comments'),
      headers: await _headers(),
      body: json.encode({"content": content}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add comment');
    }
  }
}

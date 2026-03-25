import 'dart:convert';
import 'package:http/http.dart' as http;

class RateMovieService {
  Future<void> rate({
    required String movieId,
    required int stars,
  }) async {
    final response = await http.post(
      Uri.parse("https://localhost:7132/api/movies/rate"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "movieId": movieId,
        "userId": "USR001",
        "stars": stars,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to rate movie");
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserApiDatasource {
 Future<UserModel> getCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  final response = await http.get(
    Uri.parse("https://localhost:7132/api/users/me"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  print("STATUS: ${response.statusCode}");
  print("BODY: ${response.body}");

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return UserModel.fromJson(data); // 🔥 FIX
  } else {
    throw Exception("Failed to load user");
  }
}
}
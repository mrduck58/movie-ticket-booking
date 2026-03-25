import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile_model.dart';
import 'package:http/http.dart' as http;

class ProfileDatasource {
  Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print("WATCHLIST TOKEN: $token");

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }
  Future<ProfileModel> getProfile() async {
    final response = await http.get(
      Uri.parse('https://localhost:7132/api/profile'),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return ProfileModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> updateProfile(ProfileModel profile) async {
    final response = await http.put(
      Uri.parse('https://localhost:7132/api/profile'),
      headers: await _headers(),
      body: json.encode(profile.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }
}

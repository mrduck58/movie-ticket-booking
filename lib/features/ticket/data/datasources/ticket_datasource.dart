import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ticket_model.dart';
import 'package:http/http.dart' as http;

class TicketDatasource {
  Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print("WATCHLIST TOKEN: $token");

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<List<TicketModel>> getTickets() async {
    final response = await http.get(
      Uri.parse('https://localhost:7132/api/ticket/mytickets'),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return (jsonData as List).map((e) => TicketModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load profile');
    }
  }
}

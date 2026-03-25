import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_model.dart';

class NotificationRemoteDataSource {
  final http.Client client;

  NotificationRemoteDataSource(this.client);

  static const String baseUrl = 'https://localhost:7132/api/notifications';

  Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty)
        'Authorization': 'Bearer $token',
    };
  }

  Future<List<AppNotificationModel>> getNotifications() async {
    final response = await client.get(
      Uri.parse(baseUrl),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body) as List;
      return decoded
          .map((e) => AppNotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    if (response.statusCode == 404) {
      return [];
    }

    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    }

    throw Exception('Failed to load notifications: ${response.body}');
  }

  Future<void> markAsRead(String notificationId) async {
    final response = await client.put(
      Uri.parse('$baseUrl/$notificationId/read'),
      headers: await _headers(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark as read: ${response.body}');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/$notificationId'),
      headers: await _headers(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete notification: ${response.body}');
    }
  }

  Future<void> clearAll() async {
    final response = await client.delete(
      Uri.parse('$baseUrl/clear'),
      headers: await _headers(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to clear notifications: ${response.body}');
    }
  }
}
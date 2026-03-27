import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile_model.dart';

class AccountLocalDatasource {
  Future<UserProfileModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token not found');
    }

    final payload = _parseJwt(token);

    final email = _readStringClaim(payload, [
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name',
      'unique_name',
      'email',
    ]);

    final userId = _readStringClaim(payload, [
      'UserId',
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier',
      'sub',
    ]);

    if (email.isEmpty && userId.isEmpty) {
      throw Exception('Invalid token payload');
    }

    return UserProfileModel(
      userId: userId,
      name: _getUsernameFromEmail(email),
      email: email,
      avatar: '',
    );
  }

  String _readStringClaim(Map<String, dynamic> payload, List<String> keys) {
    for (final key in keys) {
      final value = payload[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return '';
  }

  String _getUsernameFromEmail(String email) {
    if (email.isEmpty) return 'User';
    return email.split('@').first;
  }

  // String _formatDisplayName(String userId) {
  //   if (userId.trim().isEmpty) return 'User';
  //   if (userId.length <= 8) return 'User #$userId';
  //   return 'User #${userId.substring(0, 8)}';
  // }

  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid token payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String input) {
    var output = input.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string');
    }

    return utf8.decode(base64Url.decode(output));
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';

class LoginMockDatasource {
  Future<List<Map<String, dynamic>>> getAccounts() async {
    final jsonString = await rootBundle.loadString(
      'assets/mock/accounts.json',
    );

    final List<dynamic> data = jsonDecode(jsonString);

    return data.cast<Map<String, dynamic>>();
  }
}
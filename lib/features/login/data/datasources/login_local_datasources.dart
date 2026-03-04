import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/account_model.dart';

class LoginLocalDatasources {
  Future<List<Accountmodel>> getAccounts() async {
    final String response = await rootBundle.loadString(
      'assets/mock/accounts.json',
    );
    final List<dynamic> data = jsonDecode(response);
    return data.map((e) => Accountmodel.fromJson(e)).toList();
  }
}

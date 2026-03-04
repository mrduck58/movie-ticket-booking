import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/user_profile_model.dart';

class AccountLocalDatasource {
  Future<UserProfileModel> getUser() async {
    final raw = await rootBundle.loadString(
      'assets/mock/account.json',
    );

    final map = json.decode(raw);

    return UserProfileModel.fromJson(map['user']);
  }
}
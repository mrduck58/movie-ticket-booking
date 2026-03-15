import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/profile_model.dart';

class ProfileDatasource {

  Future<ProfileModel> getProfile() async {

    final jsonString =
        await rootBundle.loadString('assets/mock/profile.json');

    final jsonData = json.decode(jsonString);

    return ProfileModel.fromJson(jsonData);
  }
}
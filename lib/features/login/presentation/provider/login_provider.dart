import 'dart:math';

import 'package:flutter/material.dart';
import '../../data/repository/login_repository.dart';
class LoginProvider extends ChangeNotifier {
  final LoginRepository repository;
  LoginProvider(this.repository);
  bool isLoading = false;
  String ?errorMessage;
  Future<bool> login(String email , String password) async {
    isLoading = true;
    notifyListeners();
    final result = await repository.login(email, password);
    isLoading = false;
    if(!result){
      errorMessage = "Invalid email or password";
      notifyListeners();
      return false;
    }
    errorMessage = null;
    notifyListeners();
    return true;
  }

}
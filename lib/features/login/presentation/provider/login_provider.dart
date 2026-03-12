import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/core/network/dio_client.dart';
import 'package:movie_ticket_booking/features/login/data/repositories/login_repository_impl.dart';
import '../../domain/repositories/login_repository.dart';
import '../../data/datasources/login_api_datasources.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final dioClient = DioClient(baseUrl: "https://localhost:7132");

  final datasource = LoginApiDatasource(dioClient.dio);

  return LoginRepositoryImpl(datasource);
});

class LoginProvider extends ChangeNotifier {
  final LoginRepository repository;

  LoginProvider(this.repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String? _token;
  String? get token => _token;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final token = await repository.login(email, password);

      if (token != null) {
        _token = token;
      } else {
        _error = "Invalid email or password";
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _error = "Invalid email or password";
      } else {
        _error = "Server error";
      }
    } catch (e) {
      _error = "Login failed";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}

final loginProvider = ChangeNotifierProvider<LoginProvider>((ref) {
  final repository = ref.read(loginRepositoryProvider);
  return LoginProvider(repository);
});

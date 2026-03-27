import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/core/network/dio_client.dart';
import 'package:movie_ticket_booking/features/home/data/models/user_model.dart';
import 'package:movie_ticket_booking/features/home/presentation/providers/home_providers.dart';
import 'package:movie_ticket_booking/features/login/data/repositories/login_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/login_repository.dart';
import '../../data/datasources/login_api_datasources.dart';
import 'package:google_sign_in/google_sign_in.dart';

// 1. Cấu hình Google Sign In (Dành riêng cho Web)
final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId:
      "1007019760091-msrkcffduk67n9kao7uatqdh6toshhdp.apps.googleusercontent.com",

  // scopes: ['email', 'profile'],
);

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  // Đảm bảo URL này khớp với Backend của bạn
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

  // --- Hàm Login cũ bằng Email/Password ---
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
      _error = e.response?.data?.toString() ?? "Server error";
    } catch (e) {
      _error = "Login failed";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- 2. Hàm Login mới bằng Google ---

  Future<bool> loginWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // 1. Luôn SignOut trước để buộc hiện bảng chọn tài khoản (giúp fix lỗi cache token)
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? tokenToSend = googleAuth.accessToken;

      // Log để bạn kiểm tra ở Console F12
      print("TOKEN GỬI LÊN SERVER: $tokenToSend");

      if (tokenToSend == null) {
        _error = "Không thể lấy Token từ Google";
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final serverToken = await repository.loginWithGoogle(tokenToSend);

      if (serverToken != null) {
        _token = serverToken;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = "Server từ chối xác thực tài khoản này.";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = "Lỗi kết nối: Không thể gọi đến API Backend.";
      print("Google Auth Error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

 Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString("token");

    // Fix lỗi chuỗi 'null' quái đản trên Flutter Web
    if (savedToken == null || savedToken == 'null' || savedToken.trim().isEmpty) {
      _token = null;
    } else {
      _token = savedToken;
    }
    notifyListeners();
  }

  bool ensureAuthenticated(BuildContext context) {
    if (_token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please sign in to continue"),
          backgroundColor: Color(0xFFFF4D67),
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.push('/intro');
      return false;
    }
    return true;
  }

  // Hàm lưu/xóa email khi dùng Remember Me
  Future<void> handleRememberMe(String email, bool isRemember) async {
    final prefs = await SharedPreferences.getInstance();
    if (isRemember) {
      await prefs.setString("remembered_email", email);
    } else {
      await prefs.remove("remembered_email");
    }
  }

  Future<void> logout() async {
    await repository.logout();
    _token = null;
    notifyListeners();
  }
}

final loginProvider = ChangeNotifierProvider<LoginProvider>((ref) {
  final repo = ref.read(loginRepositoryProvider);
  return LoginProvider(repo);
});

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final auth = ref.watch(loginProvider);
  if (auth.token == null) return UserModel.guest();

  try {
    final repo = ref.read(userRepositoryProvider);
    return await repo.getCurrentUser();
  } catch (e) {
    return UserModel.guest();
  }
});

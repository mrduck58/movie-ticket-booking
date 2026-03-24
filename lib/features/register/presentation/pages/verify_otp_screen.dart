import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/register_provider.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final Map data; // Nhận {"email": ..., "password": ...} từ màn CreateAccount
  const VerifyOtpScreen({super.key, required this.data});

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  bool _isLoading = false;
  String? _errorMessage;

  // Biến cho bộ đếm ngược Resend
  Timer? _timer;
  int _start = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleResendCode() async {
    if (!_canResend) return;

    // Gọi API gửi lại OTP
    await ref
        .read(registerProvider.notifier)
        .repo
        .sendOtp(widget.data['email']);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("OTP has been resent to your email")),
    );
    _startTimer();
  }

  void _handleVerify() async {
    String otp = _controllers.map((e) => e.text).join();
    if (otp.length < 4) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final isValid = await ref
          .read(registerProvider.notifier)
          .repo
          .verifyOtp(widget.data['email'], otp);

      if (isValid) {
        if (mounted) {
          // ✅ SANG TRANG COMPLETE PROFILE
          context.go('/complete-profile', extra: widget.data);
        }
      } else {
        setState(() {
          _errorMessage = "Invalid OTP code. Please try again.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Connection error. Please try again.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Verify Email 📧",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "Check your email ${widget.data['email']} and enter the 4-digit code.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
            ),
            const SizedBox(height: 40),

            /// 4 Ô NHẬP OTP
            /// 4 Ô NHẬP OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: 65,
                  height: 75,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    // Bỏ maxLength ở đây để xử lý thủ công cho mượt trên Web
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // 1. Chặn chỉ cho nhập số
                      LengthLimitingTextInputFormatter(
                        2,
                      ), // Cho phép nhận 2 để mình tự cắt lấy 1
                    ],
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      // 2. XỬ LÝ LỖI NHẬP LOẠN (Nếu nhập "57" thì chỉ lấy "7")
                      if (value.length > 1) {
                        _controllers[index].text = value.substring(
                          value.length - 1,
                        );
                        _controllers[index]
                            .selection = TextSelection.fromPosition(
                          TextPosition(offset: _controllers[index].text.length),
                        );
                      }

                      // 3. LOGIC NHẢY Ô
                      if (value.isNotEmpty) {
                        if (index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        } else {
                          _focusNodes[index]
                              .unfocus(); // Ô cuối thì ẩn bàn phím
                        }
                      } else if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1]
                            .requestFocus(); // Xóa thì quay lại
                      }

                      // Kiểm tra đủ 4 số thì tự verify
                      String otp = _controllers.map((e) => e.text).join();
                      if (otp.length == 4) _handleVerify();
                    },
                  ),
                ),
              ),
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 20),
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],

            const SizedBox(height: 30),

            /// NÚT GỬI LẠI MÃ
            TextButton(
              onPressed: _canResend ? _handleResendCode : null,
              child: Text(
                _canResend ? "Resend Code" : "Resend Code in ${_start}s",
                style: TextStyle(
                  color: _canResend ? Colors.red : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),

            /// NÚT TIẾP TỤC
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                onPressed: _isLoading ? null : _handleVerify,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Verify & Continue",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

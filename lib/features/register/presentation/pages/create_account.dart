import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../login/presentation/pages/intro_2.dart';
import 'package:go_router/go_router.dart';
import '../provider/register_provider.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  bool isChecked = false;
  bool isPasswordHidden = true;
  bool isConfirmHidden = true;
  String? confirmError;
  String? passwordError;
  String? emailError;
  bool _isCheckingEmail = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _isPasswordStrong(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void validateAndSubmit() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmController.text;

    // 1. Reset các thông báo lỗi cũ
    setState(() {
      confirmError = null;
      emailError = null;
    });
    if (!isChecked) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("You must agree to the Terms & Conditions to continue."),
        backgroundColor: Colors.redAccent,
      ),
    );
    return; // Dừng lại ở đây, không gọi API nữa
  }
    // 2. Validate mật khẩu mạnh (8 ký tự, 1 hoa, 1 số)
    final passRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$');
    if (!passRegex.hasMatch(password)) {
      setState(
        () => passwordError =
            "Password must be at least 8 characters, include an uppercase letter and a number",
      );
      return;
    }
    if (!_isValidEmail(email)) {
      setState(
        () => emailError =
            "Please enter a valid email address (e.g. name@example.com)",
      );
      return;
    }

    // 3. Check khớp mật khẩu
    if (password != confirm) {
      setState(() => confirmError = "Passwords do not match");
      return;
    }

    // 4. Gọi API check Email (Hết gạch đỏ sau khi làm Bước 1 & 2)

    // 3. Bắt đầu gọi API
    setState(() => _isCheckingEmail = true);

    try {
      // BƯỚC A: Check email tồn tại trong DB chưa
      final emailExists = await ref
          .read(registerProvider.notifier)
          .repo
          .checkEmailExists(email);

      if (emailExists) {
        setState(() {
          emailError = "This email is already registered";
          _isCheckingEmail = false;
        });
        return;
      }

      // BƯỚC B: Gửi mã OTP về email người dùng
      final isOtpSent = await ref
          .read(registerProvider.notifier)
          .repo
          .sendOtp(email);

      setState(() => _isCheckingEmail = false);

      if (isOtpSent) {
        // BƯỚC C: CHUYỂN SANG MÀN HÌNH NHẬP OTP (Thay vì Complete Profile)
        // Dùng context.push để người dùng có thể quay lại nếu nhập sai email
        context.push(
          '/verify-otp',
          extra: {"email": email, "password": password},
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to send OTP. Please try again later."),
          ),
        );
      }
    } catch (e) {
      setState(() => _isCheckingEmail = false);
      print("Lỗi hệ thống: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          // FIX overflow
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Back Button
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const Intro2()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),

                const SizedBox(height: 10),

                /// Title
                const Text(
                  "Create Account 🙋‍♀️",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Sign up to unlock a world of movies and seamless ticket booking.",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),

                const SizedBox(height: 30),

                /// Email
                const Text("Email"),
                const SizedBox(height: 8),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    errorText: emailError,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Password
                const Text("Password"),
                const SizedBox(height: 8),

                TextField(
                  controller: passwordController,
                  obscureText: isPasswordHidden,
                  decoration: InputDecoration(
                    hintText: "Password",
                    errorText: passwordError,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Confirm Password
                const Text("Confirm Password"),
                const SizedBox(height: 8),

                TextField(
                  controller: confirmController,
                  obscureText: isConfirmHidden,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    errorText: confirmError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmHidden = !isConfirmHidden;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value ?? false; // FIX null error
                        });
                      },
                    ),
                    const Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "I agree to Cinemas ",
                          children: [
                            TextSpan(
                              text: "Terms & Conditions.",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an account? ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateAccountScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Color(0xFFFF5A5F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                /// Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _isCheckingEmail ? null : validateAndSubmit,
                    child: _isCheckingEmail
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

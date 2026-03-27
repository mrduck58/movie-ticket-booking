import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'intro_2.dart';
import '../provider/login_provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isPasswordHidden = true;
  bool rememberMe = false;

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Load email đã lưu nếu có
    _loadRememberedEmail();
  }

  _loadRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString("remembered_email");
    if (savedEmail != null) {
      emailController.text = savedEmail;
      setState(() => rememberMe = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    /// listen login success
    ref.listen<LoginProvider>(loginProvider, (previous, next) {
      if (next.token != null) {
        context.go('/');
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Back button
                IconButton(
                  onPressed: () {
                    context.go('/intro');
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),

                const SizedBox(height: 20),

                /// Title
                const Text(
                  "Welcome Back ✋",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Please enter your email and password to sign in",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),

                const SizedBox(height: 30),

                /// Email
                const Text("Email"),
                const SizedBox(height: 8),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
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
                    hintText: "password",
                    prefixIcon: const Icon(Icons.lock_outline),
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

                /// ERROR MESSAGE
                if (loginState.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      loginState.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 15),

                /// Remember + Forgot
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          activeColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                        ),
                        const Text("Remember me"),
                      ],
                    ),
                    const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                /// Sign In Button
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
                    onPressed: () async {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      // Lưu hoặc xóa email dựa trên checkbox
                      await ref
                          .read(loginProvider)
                          .handleRememberMe(email, rememberMe);

                      await ref.read(loginProvider).login(email, password);
                    },
                    child: loginState.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Sign In",
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

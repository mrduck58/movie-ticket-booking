import 'package:flutter/material.dart';
import '../../../login/presentation/pages/intro_2.dart';
import 'package:go_router/go_router.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isChecked = false;
  bool isPasswordHidden = true;
  bool isConfirmHidden = true;
  String? confirmError;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void validatePassword() {
    // 1. check password match
    if (passwordController.text != confirmController.text) {
      setState(() {
        confirmError = "Passwords do not match";
      });
      return;
    }

    // 2. check checkbox (nếu muốn bắt buộc)
    if (!isChecked) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please agree to Terms")));
      return;
    }

    // 3. nếu OK → đi tiếp
    setState(() {
      confirmError = null;
    });

    context.go(
      '/complete-profile',
      extra: {
        "email": emailController.text,
        "password": passwordController.text,
      },
    );
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
                    onPressed: validatePassword,
                    child: const Text(
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

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/home/presentation/pages/home_page.dart';
import 'intro_2.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;
  bool rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Back button
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
             Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  if (provider.errorMessage != null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        provider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
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

                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
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
                    final provider = context.read<LoginProvider>();
                    final success = await provider.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    if (success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    }
                  },
                  child: const Text(
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
    );
  }
}

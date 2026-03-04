import 'package:flutter/material.dart';
import 'create_account.dart';
import 'login_screen.dart';

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              /// Title
              const Text(
                "VPHAN Booking",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "Let’s dive in into your account!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              /// Google Button
              socialButton(
                imagePath: "assets/images/icons/google.png",
                text: "Continue with Google",
              ),

              const SizedBox(height: 16),

              /// Apple Button
              socialButton(
                imagePath: "assets/images/icons/apple.png",
                text: "Continue with Apple",
              ),

              const SizedBox(height: 16),

              /// Facebook Button
              socialButton(
                imagePath: "assets/images/icons/facebook.png",
                text: "Continue with Facebook",
              ),

              const SizedBox(height: 32),

              /// Sign in with password
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Sign in with password",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Sign up
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

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  /// Social Button Widget
  static Widget socialButton({
    required String imagePath,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 24),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

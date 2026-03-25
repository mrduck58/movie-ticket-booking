import 'package:flutter/material.dart';
import 'create_account.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = GoRouterState.of(context).extra as Map;
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateAccountScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),

                const SizedBox(height: 10),

                /// Title
                const Text(
                  "Complete Your Profile 👤",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Add the finishing touches to your profile. Let's make your movie experience more social!",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),

                const SizedBox(height: 30),

                /// Avatar
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// Full Name
                const Text("Full Name"),
                const SizedBox(height: 8),
                TextFormField(
                  controller: nameController,
                  decoration: _inputStyle("Enter your full name"),
                  // Ngăn người dùng nhập quá nhiều, ví dụ max 50 ký tự
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your name";
                    }
                    // Kiểm tra độ dài: Thường 3 ký tự là mức tối thiểu an toàn
                    if (value.trim().length < 3) {
                      return "Name is too short (minimum 3 characters)";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                 const Text("Phone number"),
                TextFormField(
                  controller: phoneController,
                  keyboardType:
                      TextInputType.text, // Để hiện bàn phím chữ/số bình thường
                  decoration: _inputStyle("Enter your phone number"),
                  // XÓA phần inputFormatters ở đây để cho phép nhập chữ thoải mái
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }

                    // 1. Kiểm tra xem có ký tự chữ nào không (Regex: chỉ cho phép 0-9)
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "Phone number must contain only digits";
                    }

                    // 2. Kiểm tra độ dài 10 hoặc 11
                    if (value.length < 10 || value.length > 11) {
                      return "Phone number must be 10 or 11 digits";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                /// Date of Birth
                const Text("Date of Birth"),
                const SizedBox(height: 8),
                TextFormField(
                  controller: dobController,
                  readOnly: true,
                  decoration: _inputStyle("Select your date of birth"),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      dobController.text =
                          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select your date of birth";
                    }
                    return null;
                  },
                ),

                const Spacer(),

                /// Finish Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3B30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.go(
                          '/movie-interest',
                          extra: {
                            ...args,
                            "fullName": nameController.text,
                            "phone": phoneController.text,
                            "dateOfBirth": dobController.text,
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Finish",
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

  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}

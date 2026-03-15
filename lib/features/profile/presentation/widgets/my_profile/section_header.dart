import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {

  final VoidCallback onTap;

  const SectionHeader({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          const Text(
            "Thông tin cơ bản",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          GestureDetector(
            onTap: onTap,
            child: const Text(
              "Chỉnh sửa",
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
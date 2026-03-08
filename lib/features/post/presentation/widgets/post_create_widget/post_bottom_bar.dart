import 'package:flutter/material.dart';

class PostBottomBar extends StatelessWidget {
  final int charCount;
  final VoidCallback onPickImage;
  final VoidCallback onSubmit;

  const PostBottomBar({
    super.key,
    required this.charCount,
    required this.onPickImage,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.text_fields, color: Colors.pink),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: onPickImage,
                child: const Icon(Icons.image_outlined, color: Colors.blue),
              ),
              const Spacer(),
              Text(
                "$charCount/10000",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),

          GestureDetector(
            onTap: onSubmit,
            child: Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE91E63), Color(0xFFD81B60)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                "Đăng bài viết",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
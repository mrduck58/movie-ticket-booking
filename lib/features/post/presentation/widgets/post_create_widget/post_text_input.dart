import 'package:flutter/material.dart';

class PostTextInput extends StatelessWidget {
  final TextEditingController controller;

  const PostTextInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: controller,
          maxLines: null,
          expands: true,
          decoration: const InputDecoration(
            hintText: "Chia sẻ cảm nghĩ của bạn...",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
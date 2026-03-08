import 'package:flutter/material.dart';

class CommentInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const CommentInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
      ),
      child: Row(
        children: [

          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Viết bình luận...",
              ),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.send),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
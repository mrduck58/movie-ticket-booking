import 'package:flutter/material.dart';

class ReactionBar extends StatelessWidget {
  final Function(String) onReact;

  const ReactionBar({super.key, required this.onReact});

  @override
  Widget build(BuildContext context) {
    const reactions = ["👍", "❤️", "😂", "😮", "😢", "😡"];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: reactions.map((emoji) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () => onReact(emoji),
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

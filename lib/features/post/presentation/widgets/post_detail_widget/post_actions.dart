import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  final bool isLiked;
  final String currentReaction;
  final Animation<double> scaleAnimation;
  final VoidCallback onLike;
  final VoidCallback onLongPress;

  const PostActions({
    super.key,
    required this.isLiked,
    required this.currentReaction,
    required this.scaleAnimation,
    required this.onLike,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        GestureDetector(
          onTap: onLike,
          onLongPress: onLongPress,
          child: Row(
            children: [

              ScaleTransition(
                scale: scaleAnimation,
                child: isLiked
                    ? Text(
                        currentReaction,
                        style: const TextStyle(fontSize: 22),
                      )
                    : const Icon(Icons.thumb_up_alt_outlined),
              ),

              const SizedBox(width: 4),

              Text(
                "Thích",
                style: TextStyle(
                  color: isLiked ? Colors.blue : Colors.black54,
                ),
              ),
            ],
          ),
        ),

        const Text("Bình luận"),
        const Text("Chia sẻ"),
      ],
    );
  }
}
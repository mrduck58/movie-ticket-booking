import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/presentation/providers/post_providers.dart';

class PostActions extends ConsumerWidget {
  final String postId;
  final bool isLiked;
  final String currentReaction;
  final Animation<double> scaleAnimation;

  const PostActions({
    super.key,
    required this.postId,
    required this.isLiked,
    required this.currentReaction,
    required this.scaleAnimation,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String reaction = "👍";

    ref.watch(postControllerProvider);
    final controller = ref.read(postControllerProvider.notifier);
    final liked = controller.likedPosts[postId] ?? isLiked;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            controller.likePost(postId);
          },
          child: Row(
            children: [
              ScaleTransition(
                scale: scaleAnimation,
                child: liked
                    ? Text(reaction, style: const TextStyle(fontSize: 22))
                    : Icon(
                        liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                        color: liked ? Colors.blue : Colors.black,
                      ),
              ),
              const SizedBox(width: 4),

              Text(
                "Thích",
                style: TextStyle(color: liked ? Colors.blue : Colors.black54),
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

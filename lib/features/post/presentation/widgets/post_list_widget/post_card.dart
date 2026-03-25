import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/presentation/pages/post_detail.dart';
import 'package:movie_ticket_booking/features/post/presentation/providers/post_providers.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../data/models/post_model.dart';
import 'reaction_bar.dart';

class PostCard extends ConsumerStatefulWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  String reaction = "👍";
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlay;

  void showReactions() {
    if (overlay != null) return;

    overlay = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: hideReactions,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: layerLink,
              offset: const Offset(-60, -70),
              child: Material(
                color: Colors.transparent,
                child: ReactionBar(
                  onReact: (emoji) {
                    setState(() {
                      reaction = emoji;
                    });

                    ref
                        .read(postControllerProvider.notifier)
                        .likePost(widget.post.id);

                    hideReactions();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(overlay!);
  }

  void hideReactions() {
    overlay?.remove();
    overlay = null;
  }

  @override
  void dispose() {
    hideReactions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(postControllerProvider.notifier);
    final isLiked =
        controller.likedPosts[widget.post.id] ?? widget.post.isLiked;

    final post = widget.post;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(post.avatar)),
              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  post.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Text(
                timeago.format(post.time, locale: 'vi'),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// CONTENT
          Text(post.content),

          if (post.image != null) ...[
            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                post.image!,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  );
                },
              ),
            ),
          ],

          const SizedBox(height: 10),

          /// LIKE COUNT
          Text(
            "${post.likes} lượt thích",
            style: const TextStyle(color: Colors.grey),
          ),

          const Divider(),

          /// ACTIONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// LIKE
              CompositedTransformTarget(
                link: layerLink,
                child: GestureDetector(
                  onTap: () {
                    ref.read(postControllerProvider.notifier).likePost(post.id);
                  },

                  // onLongPress: showReactions,
                  child: Row(
                    children: [
                      isLiked
                          ? Text(reaction, style: const TextStyle(fontSize: 22))
                          : Icon(
                              isLiked
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_alt_outlined,
                              color: isLiked ? Colors.blue : Colors.black,
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
              ),

              /// COMMENT
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostDetailScreen(post: post),
                    ),
                  );
                },
                child: const Text("Bình luận"),
              ),

              const Text("Chia sẻ"),
            ],
          ),
        ],
      ),
    );
  }
}

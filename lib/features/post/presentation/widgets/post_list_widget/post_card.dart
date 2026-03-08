
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/post/presentation/pages/post_detail.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../data/models/post_model.dart';
import 'reaction_bar.dart';

class PostCard extends StatefulWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  String reaction = "👍";
  late int likeCount;

  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlay;

  @override
  void initState() {
    super.initState();
    likeCount = widget.post.likes;
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount--;
      } else {
        likeCount++;
      }
      isLiked = !isLiked;
    });
  }

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
            offset: const Offset(-60, -70), // giảm offset
            child: Material(
              color: Colors.transparent,
              child: ReactionBar(
                onReact: (emoji) {
                  setState(() {
                    reaction = emoji;
                    if (!isLiked) likeCount++;
                    isLiked = true;
                  });
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
              child: Image.network(post.image!),
            ),
          ],

          const SizedBox(height: 10),

          /// LIKE COUNT
          Text(
            "$likeCount lượt thích",
            style: const TextStyle(color: Colors.grey),
          ),

          const Divider(),

          /// ACTIONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CompositedTransformTarget(
                link: layerLink,
                child: GestureDetector(
                  onTap: toggleLike,
                  onLongPress: showReactions,
                  child: Row(
                    children: [
                      isLiked
                          ? Text(
                              reaction,
                              style: const TextStyle(fontSize: 22),
                            )
                          : const Icon(Icons.thumb_up_alt_outlined),
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

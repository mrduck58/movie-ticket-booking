import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/data/models/post_model.dart';
import 'package:movie_ticket_booking/features/post/presentation/providers/post_providers.dart';
import 'package:movie_ticket_booking/features/post/presentation/widgets/post_list_widget/reaction_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
// import '../../providers/post_controller.dart';

import 'post_header.dart';
import 'post_content.dart';
import 'post_actions.dart';
import 'comment_list.dart';
import 'comment_input.dart';

class PostDetailView extends ConsumerStatefulWidget {
  final PostModel post;

  const PostDetailView({super.key, required this.post});

  @override
  ConsumerState<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends ConsumerState<PostDetailView>
    with SingleTickerProviderStateMixin {
  final TextEditingController commentController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool isLiked = false;
  late int likeCount;
  String currentReaction = "👍";

  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;

  late AnimationController animController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    likeCount = widget.post.likes;

    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 1.4).animate(animController);
  }

  void toggleLike() {
    setState(() {
      isLiked ? likeCount-- : likeCount++;
      isLiked = !isLiked;
    });

    animController.forward().then((_) => animController.reverse());
  }

  void showReactions() {
    if (overlayEntry != null) return;

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: hideReactions,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: layerLink,
              offset: const Offset(160, -70),
              child: Material(
                color: Colors.transparent,
                child: ReactionBar(
                  onReact: (emoji) {
                    if (!mounted) return;

                    setState(() {
                      currentReaction = emoji;
                      if (!isLiked) likeCount++;
                      isLiked = true;
                    });

                    animController.forward().then((_) {
                      animController.reverse();
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

    Overlay.of(context, rootOverlay: true).insert(overlayEntry!);
  }

  void hideReactions() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void addComment() {
    final text = commentController.text.trim();
    if (text.isEmpty) return;

    ref
        .read(postCommentControllerProvider.notifier)
        .addComment(commentController.text.trim());

    /// scroll xuống comment mới
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    animController.dispose();
    hideReactions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// watch để rebuild khi comment thay đổi
    ref.watch(postControllerProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text("Chi tiết bài viết"),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                PostHeader(post: widget.post),

                const SizedBox(height: 16),

                PostContent(post: widget.post),

                const SizedBox(height: 20),

                Row(
                  children: [
                    const Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text("$likeCount lượt thích"),
                  ],
                ),

                const Divider(),

                CompositedTransformTarget(
                  link: layerLink,
                  child: PostActions(
                    isLiked: isLiked,
                    currentReaction: currentReaction,
                    scaleAnimation: scaleAnimation,
                    onLike: toggleLike,
                    onLongPress: showReactions,
                  ),
                ),

                const Divider(),

                const CommentList(),
              ],
            ),
          ),

          CommentInput(controller: commentController, onSend: addComment),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/data/models/post_model.dart';
import 'package:movie_ticket_booking/features/post/presentation/providers/post_providers.dart';

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

  String currentReaction = "👍";

  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;

  late AnimationController animController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 1.4).animate(animController);
  }

  void addComment() {
    final text = commentController.text.trim();
    if (text.isEmpty) return;

    ref
        .read(postCommentControllerProvider(widget.post.id).notifier)
        .addComment(text);
    commentController.clear(); 
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
    overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// lấy post mới nhất từ Riverpod
    final postsAsync = ref.watch(postControllerProvider);
    final posts = postsAsync.value ?? [];

    final post = posts.firstWhere(
      (p) => p.id == widget.post.id,
      orElse: () => widget.post, // fallback
    );
    final controller = ref.watch(postControllerProvider.notifier);
    final isLiked = controller.likedPosts[post.id] ?? post.isLiked;

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
                /// HEADER
                PostHeader(post: widget.post),

                const SizedBox(height: 16),

                /// CONTENT
                PostContent(post: widget.post),

                const SizedBox(height: 20),

                /// LIKE COUNT
                Row(
                  children: [
                    const Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text("${post.likes} lượt thích"),
                  ],
                ),

                const Divider(),

                /// ACTIONS
                CompositedTransformTarget(
                  link: layerLink,
                  child: PostActions(
                    postId: post.id,
                    isLiked: isLiked,
                    currentReaction: currentReaction,
                    scaleAnimation: scaleAnimation,
                  ),
                ),

                const Divider(),

                CommentList(postId: post.id),
              ],
            ),
          ),

          /// COMMENT INPUT
          CommentInput(controller: commentController, onSend: addComment),
        ],
      ),
    );
  }
}

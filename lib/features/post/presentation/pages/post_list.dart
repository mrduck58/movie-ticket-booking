import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/data/models/post_model.dart';

import '../providers/post_providers.dart';
import '../widgets/post_list_widget/post_composer.dart';
import '../widgets/post_list_widget/post_card.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Cộng Đồng Ghiền Xem Phim")),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (posts) {
          return ListView.builder(
            itemCount: posts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) return const PostComposer();

              final post = posts[index - 1];

              return PostCard(
                key: ValueKey(post.id),
                post: PostModel(
                  id: post.id,
                  name: post.name,
                  time: post.time,
                  content: post.content,
                  likes: post.likes,
                  avatar: post.avatar,
                  image: post.image,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

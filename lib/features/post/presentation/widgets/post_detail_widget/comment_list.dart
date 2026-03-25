import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/presentation/providers/post_providers.dart';

class CommentList extends ConsumerWidget {
  final String postId;

  const CommentList({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postCommentControllerProvider(postId));

    return state.when(
      data: (comments) {
        return Column(
          children: comments.map((c) {
            return ListTile(
              // leading: const CircleAvatar(
              //   backgroundImage: AssetImage("assets/images/IMG_0006.JPG"),
              // ),
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(c.name),
              subtitle: Text(c.content),
            );
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text(e.toString()),
    );
  }
}

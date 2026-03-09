import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/presentation/providers/post_providers.dart';

class CommentList extends ConsumerWidget {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postCommentControllerProvider);

    return state.when(
      data: (comments) {
        return Column(
          children: comments.map((c) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatars/IMG_0006.JPG"),
              ),
              title: Text(c.name),
              subtitle: Text(c.content),
            );
          }).toList(),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text(e.toString()),
    );
  }
}

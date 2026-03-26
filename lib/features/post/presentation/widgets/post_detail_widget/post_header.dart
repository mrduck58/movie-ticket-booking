import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/post/data/models/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostHeader extends StatelessWidget {
  final PostModel post;

  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final avatar = post.avatar; // URL avatar từ PostModel
    final name = post.name;
    final initials = name.isNotEmpty
        ? name.split(' ').map((e) => e[0]).take(2).join()
        : 'ĐV';

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.pink,
          backgroundImage: avatar != null && avatar.isNotEmpty
              ? NetworkImage(avatar)
              : null,
          child: avatar == null || avatar.isEmpty
              ? Text(
                  initials,
                  style: const TextStyle(color: Colors.white),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              timeago.format(post.time, locale: 'vi'),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
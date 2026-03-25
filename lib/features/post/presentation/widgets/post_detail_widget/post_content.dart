import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/post/data/models/post_model.dart';

class PostContent extends StatelessWidget {
  final PostModel post;

  const PostContent({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          post.content,
          style: const TextStyle(fontSize: 16),
        ),

        const SizedBox(height: 16),

        if (post.image != null && post.image!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              post.image!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  );
                },
            ),
          ),
      ],
    );
  }
}
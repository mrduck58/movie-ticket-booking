import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/post/data/models/post_model.dart';
import 'package:movie_ticket_booking/features/post/presentation/widgets/post_detail_widget/post_detail_view.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PostDetailView(post: post),
    );
  }
}
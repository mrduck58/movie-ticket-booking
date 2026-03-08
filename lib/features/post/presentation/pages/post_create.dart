import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/presentation/widgets/post_create_widget/create_post_view.dart';

class CreatePostScreen extends ConsumerWidget {
  final bool autoPickImage;

  const CreatePostScreen({super.key, this.autoPickImage = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CreatePostView(autoPickImage: autoPickImage);
  }
}
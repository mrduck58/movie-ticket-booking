import 'package:movie_ticket_booking/features/post/domain/entities/post_comment.dart';

import '../../domain/entities/post.dart';

class PostState {
  final List<Post> posts;

  const PostState({
    required this.posts,
  });
  
}

class PostCommentState {
  final List<PostComment> comments;

  const PostCommentState({
    required this.comments,
  });
}
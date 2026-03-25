import 'package:movie_ticket_booking/features/post/domain/entities/create_post.dart';

import '../entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Map<String, dynamic>> toggleLike(
    String id,
  ); // Future<void> createPost(Post post);
  Future<void> createPost(CreatePost post);
}

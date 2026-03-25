import '../entities/post_comment.dart';

abstract class PostCommentRepository {
  Future<List<PostComment>> getComments(String postId);
  Future<void> addComment(String postId, String content);
}
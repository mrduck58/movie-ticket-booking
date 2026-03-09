import '../entities/post_comment.dart';

abstract class PostCommentRepository {
  Future<List<PostComment>> getComments();
}
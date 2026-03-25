import '../../domain/entities/post_comment.dart';
import '../../domain/repositories/post_comment_repository.dart';
import '../datasources/post_comment_local_datasource.dart';

class PostCommentRepositoryImpl implements PostCommentRepository {
  final PostCommentRemoteDatasource datasource;

  PostCommentRepositoryImpl(this.datasource);

  @override
  Future<List<PostComment>> getComments(String postId) async {
    final models = await datasource.getComments(postId);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addComment(String postId, String content) async {
    await datasource.addComment(postId: postId, content: content);
  }
}

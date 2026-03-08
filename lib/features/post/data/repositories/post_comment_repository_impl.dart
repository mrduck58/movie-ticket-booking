import '../../domain/entities/post_comment.dart';
import '../../domain/repositories/post_comment_repository.dart';
import '../datasources/post_comment_local_datasource.dart';

class PostCommentRepositoryImpl implements PostCommentRepository {
  final PostCommentLocalDatasource datasource;

  PostCommentRepositoryImpl(this.datasource);

  @override
  @override
  Future<List<PostComment>> getComments() async {
    final models = await datasource.getComments();
    return models.map((e) => e as PostComment).toList();
  }
}

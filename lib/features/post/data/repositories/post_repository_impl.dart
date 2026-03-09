import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_local_datasource.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostLocalDataSource datasource;

  PostRepositoryImpl(this.datasource);

  @override
  Future<List<Post>> getPosts() async {
  final models = await datasource.getPosts();

  return List<Post>.from(models);
}

  @override
  Future<void> createPost(Post post) async {
    final model = PostModel(
      id: post.id,
      name: post.name,
      time: post.time,
      likes: post.likes,
      content: post.content,
      image: post.image,
      avatar: post.avatar
    );

    await datasource.createPost(model);
  }
}

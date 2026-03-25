import 'package:movie_ticket_booking/features/post/data/datasources/post_remote_datasource.dart';
import 'package:movie_ticket_booking/features/post/data/models/create_post_model.dart';
import 'package:movie_ticket_booking/features/post/domain/entities/create_post.dart';

import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  // final PostLocalDataSource datasource;
  final PostRemoteDataSource datasource;
  PostRepositoryImpl(this.datasource);

  @override
  Future<List<Post>> getPosts() async {
    final models = await datasource.getPosts();

    return List<Post>.from(models);
  }

  @override
  Future<Map<String, dynamic>> toggleLike(String id) {
    return datasource.toggleLike(id);
  }

  @override
  Future<void> createPost(CreatePost post) async {
    final model = CreatePostModel.fromEntity(post);
    await datasource.createPost(model);
  }
}

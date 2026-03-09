import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/data/datasources/post_comment_local_datasource.dart';
import 'package:movie_ticket_booking/features/post/data/repositories/post_comment_repository_impl.dart';
import 'package:movie_ticket_booking/features/post/domain/entities/post_comment.dart';
import 'package:movie_ticket_booking/features/post/domain/repositories/post_comment_repository.dart';
import '../../domain/entities/post.dart';
import '../../data/datasources/post_local_datasource.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/repositories/post_repository.dart';
import 'post_controller.dart';

final postLocalDatasourceProvider =
    Provider((ref) => PostLocalDataSource());

final postRepositoryProvider =
    Provider<PostRepository>((ref) {
  return PostRepositoryImpl(
    ref.watch(postLocalDatasourceProvider),
  );
});

final postControllerProvider =
    AsyncNotifierProvider<PostController, List<Post>>(
  PostController.new,
);
//post comment

final postCommentDatasourceProvider =
    Provider((ref) => PostCommentLocalDatasource());

final postCommentRepositoryProvider =
    Provider<PostCommentRepository>((ref) {
  return PostCommentRepositoryImpl(
    ref.watch(postCommentDatasourceProvider),
  );
});

final postCommentControllerProvider =
    AsyncNotifierProvider<PostCommentController, List<PostComment>>(
  PostCommentController.new,
);
//post create

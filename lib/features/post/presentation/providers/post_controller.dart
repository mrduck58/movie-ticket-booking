import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/features/post/domain/entities/create_post.dart';

import '../../domain/entities/post.dart';
// import '../../domain/repositories/post_repository.dart';
import 'post_providers.dart';
import '../../domain/entities/post_comment.dart';
import '../../domain/repositories/post_comment_repository.dart';

//Post controller
class PostController extends AsyncNotifier<List<Post>> {
  // late final PostRepository _repo;
  final Map<String, bool> likedPosts = {};
  @override
  Future<List<Post>> build() async {
    final repo = ref.read(postRepositoryProvider);

    final posts = await repo.getPosts();

    posts.sort((a, b) => b.time.compareTo(a.time));

    return posts;
  }

  Future<void> likePost(String id) async {
    final repo = ref.read(postRepositoryProvider);

    final current = state.value ?? [];

    final response = await repo.toggleLike(id);

    likedPosts[id] = response["isLiked"];

    final updated = current.map((p) {
      if (p.id == id) {
        return p.copyWith(likes: response["likes"]);
      }
      return p;
    }).toList();

    state = AsyncData(updated);
  }

  Future<void> createPost(String content) async {
    final repo = ref.read(postRepositoryProvider);

    try {
      await repo.createPost(CreatePost(content: content));

      // reload lại list post
      final posts = await repo.getPosts();
      posts.sort((a, b) => b.time.compareTo(a.time));

      state = AsyncData(posts);
    } catch (e) {
      print(e);
    }
  }
}

//post_comment controller
class PostCommentController extends AsyncNotifier<List<PostComment>> {
  final String postId;

  PostCommentController(this.postId);

  late final PostCommentRepository _repo;

  @override
  Future<List<PostComment>> build() async {
    final repo = ref.read(postCommentRepositoryProvider);
    return await repo.getComments(postId);
  }

  Future<void> addComment(String text) async {
    final repo = ref.read(postCommentRepositoryProvider);

    final current = state.value ?? [];

    final newComment = PostComment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: "Bạn",
      avatar: "",
      content: text,
    );

    state = AsyncData([newComment, ...current]);

    try {
      await repo.addComment(postId, text);
    } catch (e) {
      state = AsyncData(current);
    }
  }
}
  //post_create
  
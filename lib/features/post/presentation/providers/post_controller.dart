import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import 'post_providers.dart';
import '../../domain/entities/post_comment.dart';
import '../../domain/repositories/post_comment_repository.dart';

//Post controller
class PostController extends AsyncNotifier<List<Post>> {
  late final PostRepository _repo;

  @override
  Future<List<Post>> build() async {
    _repo = ref.read(postRepositoryProvider);

    final posts = await _repo.getPosts();

    posts.sort((a, b) => b.time.compareTo(a.time));

    return posts;
  }

  Future<void> createPost(String content, String? imageUrl) async {
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch,
      name: "vuong",
      likes: 0,
      time: DateTime.now(),
      content: content,
      image: imageUrl,
      avatar: "",
    );

    await _repo.createPost(newPost);

    final currentPosts = state.value ?? [];

    state = AsyncData([newPost, ...currentPosts]);
  }

  Future<void> likePost(int id) async {
    final current = state.value ?? [];

    final updated = current.map((p) {
      if (p.id == id) {
        return p.copyWith(likes: p.likes + 1);
      }
      return p;
    }).toList();

    state = AsyncData(updated);
  }
}

//post_comment controller
class PostCommentController extends AsyncNotifier<List<PostComment>> {
  late final PostCommentRepository _repo;

  @override
  Future<List<PostComment>> build() async {
    _repo = ref.read(postCommentRepositoryProvider);

    return await _repo.getComments();
  }

  Future<void> addComment(String text) async {
    final newComment = PostComment(name: "Bạn", content: text);

    final current = state.value ?? [];

    state = AsyncData([newComment, ...current]);
  }
}
  //post_create
  
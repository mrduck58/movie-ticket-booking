import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/post_model.dart';

class PostLocalDataSource {
  List<PostModel> _posts = [];

  Future<List<PostModel>> getPosts() async {
    if (_posts.isEmpty) {
      final jsonString = await rootBundle.loadString(
        'assets/mock/post_list.json',
      );

      final data = json.decode(jsonString);

      List list = data["posts"];

      _posts = list.map((e) => PostModel.fromJson(e)).toList();
    }

    return _posts;
  }

  Future<void> createPost(PostModel post) async {
    _posts.insert(0, post);
  }
}

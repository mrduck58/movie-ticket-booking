import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/post_comment_model.dart';

class PostCommentLocalDatasource {
  Future<List<PostCommentModel>> getComments() async {
    final jsonString =
        await rootBundle.loadString('assets/mock/post_comment.json');

    final List data = json.decode(jsonString);

    return data.map((e) => PostCommentModel.fromJson(e)).toList();
  }
}
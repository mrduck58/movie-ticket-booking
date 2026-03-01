import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final String movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Movie $movieId')),
      body: Center(child: Text('Movie Detail Page')),
    );
  }
}
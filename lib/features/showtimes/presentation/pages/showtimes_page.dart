import 'package:flutter/material.dart';

class ShowtimesPage extends StatelessWidget {
  final String movieId;
  const ShowtimesPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Showtimes for $movieId'),),
      body: Center(child: Text('Showtimes')),
    );
  }
}
import 'package:flutter/material.dart';

class MovieHeader extends StatelessWidget {
  final dynamic movie;

  const MovieHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 420,
      pinned: true,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(movie.posterUrl, fit: BoxFit.cover),

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(movie.rating.toString(),
                          style: const TextStyle(color: Colors.white)),

                      const SizedBox(width: 10),

                      Text("${movie.durationMin} min",
                          style:
                              const TextStyle(color: Colors.white70)),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(movie.genres.join(", "),
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
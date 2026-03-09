import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/home_providers.dart';
import '../../data/models/movie_model.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft_provider.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieProvider);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Now Playing",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: movieAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (movies) {
          final nowPlaying = movies
              .where((m) => m.releaseDate.isBefore(DateTime.now()))
              .toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: GridView.builder(
              itemCount: nowPlaying.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.65,
              ),

              itemBuilder: (context, index) {
                final movie = nowPlaying[index];

                return _MovieCard(movie: movie);
              },
            ),
          );
        },
      ),
    );
  }
}

class _MovieCard extends ConsumerWidget {
  final MovieModel movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const accent = Color(0xFFFF4D67);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              context.push('/movie/${movie.id}');
            },

            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          movie.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),

        const SizedBox(height: 6),

        OutlinedButton(
          onPressed: () {
            context.push('/movie/${movie.id}');
          },

          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: accent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          child: const Text(
            "Book Now",
            style: TextStyle(color: accent, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

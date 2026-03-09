
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../home/presentation/providers/home_providers.dart';

import '../../../checkout/providers/booking_draft_provider.dart';

class MovieDetailPage extends ConsumerWidget {
  final String movieId;

  const MovieDetailPage({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(movieProvider);

    return moviesAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text(e.toString())),
      ),
      data: (movies) {
        final movie = movies.firstWhere(
          (m) => m.id == movieId,
          orElse: () => movies.first,
        );

        return Scaffold(
          backgroundColor: const Color(0xfff4f4f4),
          body: CustomScrollView(
            slivers: [
              /// POSTER APP BAR
              SliverAppBar(
                expandedHeight: 420,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        movie.posterUrl,
                        fit: BoxFit.cover,
                      ),

                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black87,
                            ],
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
                            Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber),
                                const SizedBox(width: 4),

                                Text(
                                  movie.rating.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),

                                const SizedBox(width: 10),

                                Text(
                                  "${movie.durationMin} min",
                                  style:
                                      const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Text(
                              movie.genres.join(", "),
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              /// CONTENT
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// BOOK BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            ref.read(bookingDraftProvider.notifier).setMovie(movie.toEntity());
                            context.push('/choose-cinema/${movie.id}');
                          },
                          child: const Text(
                            "Book Now",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// TRAILER
                      const Text(
                        "Trailer",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(movie.trailer);

                          if (await canLaunchUrl(url)) {
                            launchUrl(url);
                          }
                        },

                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                movie.posterUrl,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// SYNOPSIS
                      const Text(
                        "Synopsis",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "An epic cinematic journey exploring "
                        "the fate of humanity across worlds. "
                        "Follow the hero as he battles powerful "
                        "forces to protect the future.",
                        style: TextStyle(
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// CAST
                      const Text(
                        "Cast",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        height: 120,

                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movie.cast.length,

                          itemBuilder: (context, index) {
                            final actor = movie.cast[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 16),

                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        NetworkImage(actor.imageUrl),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    actor.name,
                                    style:
                                        const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// PHOTOS
                      const Text(
                        "Photos",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        height: 110,

                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,

                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 12),

                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(12),

                                child: Image.network(
                                  movie.posterUrl,
                                  width: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// RATE MOVIE
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          minimumSize:
                              const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          _showRatingDialog(context);
                        },
                        child: const Text(
                          "Rate this Movie",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

void _showRatingDialog(BuildContext context) {
  int stars = 0;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Rate this movie",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      icon: Icon(
                        index < stars
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 34,
                      ),
                      onPressed: () {
                        setState(() {
                          stars = index + 1;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"),
                )
              ],
            ),
          );
        },
      );
    },
  );
}


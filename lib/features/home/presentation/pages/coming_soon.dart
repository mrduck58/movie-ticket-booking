import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/home_providers.dart';

class ComingSoonPage extends ConsumerWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieProvider);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Coming Soon"),
        centerTitle: true,
      ),

      body: movieAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (movies) {

          final comingSoon = movies
              .where((m) => m.releaseDate.isAfter(DateTime.now()))
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: comingSoon.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.65,
              ),

              itemBuilder: (context, index) {

                final movie = comingSoon[index];

                return Column(
                  children: [

                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          movie.posterUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    OutlinedButton(
                      onPressed: () {
                        context.go('/movie/${movie.id}');
                      },

                      child: const Text("View Detail"),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
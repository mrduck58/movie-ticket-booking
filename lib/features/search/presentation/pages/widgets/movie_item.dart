import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/watchlist/presentation/providers/watchlist_providers.dart';

import '../../../domain/entities/movie.dart';
import '../utils/search_formatters.dart';

class MovieItem extends ConsumerWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  void _openMovieDetail(BuildContext context) {
    context.push('/movies/${movie.id}');
  }

  void _openBookingFlow(BuildContext context) {
    context.push('/movies/${movie.id}/cinemas');
  }

  Future<void> _toggleWatchlist(
    BuildContext context,
    WidgetRef ref,
    bool isInWatchlist,
  ) async {
    try {
      final notifier = ref.read(watchlistControllerProvider.notifier);

      if (isInWatchlist) {
        await notifier.removeItem(movie.id);
      } else {
        await notifier.addToWatchlist(movie.id);
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isInWatchlist
                ? '"${movie.title}" đã được xoá khỏi watchlist'
                : '"${movie.title}" đã được thêm vào watchlist',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Có lỗi xảy ra: $e')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistAsync = ref.watch(watchlistControllerProvider);

    final isInWatchlist = watchlistAsync.maybeWhen(
      data: (state) => state.watchlist.any((item) => item.id == movie.id),
      orElse: () => false,
    );

    final isWatched = watchlistAsync.maybeWhen(
      data: (state) => state.watched.any((item) => item.id == movie.id),
      orElse: () => false,
    );

    final isLoading = watchlistAsync.isLoading;

    return ListTile(
      onTap: () => _openMovieDetail(context),

      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: movie.posterUrl.isNotEmpty
            ? Image.network(
                movie.posterUrl,
                width: 40,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 40,
                  height: 60,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              )
            : Container(
                width: 40,
                height: 60,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported_outlined),
              ),
      ),

      title: Text(
        movie.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(formatMovieDuration(movie.duration)),
          const SizedBox(height: 6),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: movieStatusColor(movie.status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  movieStatusText(movie.status),
                  style: TextStyle(
                    fontSize: 11,
                    color: movieStatusColor(movie.status),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: isWatched
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 22,
                    )
                  : IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: isLoading
                          ? null
                          : () => _toggleWatchlist(context, ref, isInWatchlist),
                      icon: isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(
                              isInWatchlist
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isInWatchlist ? Colors.red : Colors.grey,
                              size: 22,
                            ),
                    ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _openBookingFlow(context),
            child: const Text('Đặt vé'),
          ),
        ],
      ),
    );
  }
}

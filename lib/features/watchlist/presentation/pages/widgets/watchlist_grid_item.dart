import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../domain/entities/movie.dart';
import '../../providers/watchlist_providers.dart';
import '../dialogs/remove_watchlist_dialog.dart';

class WatchlistGridItem extends ConsumerWidget {
  final Movie movie;
  final double posterHeight;

  const WatchlistGridItem({
    super.key,
    required this.movie,
    required this.posterHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const gap1 = 10.0;
    const titleHeight = 20.0;
    const gap2 = 10.0;
    const pillHeight = 36.0;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: () {
        context.push('/movies/${movie.id}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: SizedBox(
              height: posterHeight,
              width: double.infinity,
              child: movie.posterUrl.isNotEmpty
                  ? Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_not_supported_outlined),
                      ),
                    )
                  : Container(
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported_outlined),
                    ),
            ),
          ),

          const SizedBox(height: gap1),

          SizedBox(
            height: titleHeight,
            child: Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: gap2),

          SizedBox(
            height: pillHeight,
            width: double.infinity,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () async {
                final shouldRemove = await showRemoveConfirmDialog(
                  context,
                  movieTitle: movie.title,
                );

                if (shouldRemove == true) {
                  await ref
                      .read(watchlistControllerProvider.notifier)
                      .removeItem(movie.id);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('"${movie.title}" removed from watchlist'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.error, width: 1.2),
                  color: AppColors.error.withOpacity(0.08),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite, color: AppColors.error, size: 16),
                    SizedBox(width: 7),
                    Text(
                      'In Watchlist',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
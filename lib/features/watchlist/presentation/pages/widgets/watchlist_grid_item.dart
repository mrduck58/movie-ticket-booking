import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Màu dùng chung từ core.
/// Dùng cho viền / nền / icon / text của pill "In Watchlist".
import '../../../../../core/theme/app_colors.dart';

/// Radius dùng chung từ core.
/// Dùng cho bo góc poster.
import '../../../../../core/theme/app_radius.dart';

/// Entity Movie của feature watchlist.
import '../../../domain/entities/movie.dart';

/// Provider để gọi action remove item khỏi watchlist.
import '../../providers/watchlist_providers.dart';

/// Dialog xác nhận remove.
import '../dialogs/remove_watchlist_dialog.dart';

/// =======================================================
/// ITEM CỦA GRID WATCHLIST
/// - mỗi item gồm:
///   + poster
///   + title
///   + pill button "In Watchlist"
///
/// Dùng ConsumerWidget vì:
/// - cần đọc notifier từ Riverpod để remove item
/// =======================================================
class WatchlistGridItem extends ConsumerWidget {
  final Movie movie;

  /// posterHeight được truyền từ grid parent
  /// để mọi item trong grid có kích thước đồng nhất.
  final double posterHeight;

  const WatchlistGridItem({
    super.key,
    required this.movie,
    required this.posterHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Khoảng cách cố định trong item.
    const gap1 = 10.0;
    const titleHeight = 20.0;
    const gap2 = 10.0;
    const pillHeight = 36.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// =========================
        /// POSTER
        /// - bo góc
        /// - nếu lỗi hoặc rỗng thì hiện placeholder
        /// =========================
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

        /// =========================
        /// TITLE
        /// - 1 dòng
        /// - dài quá thì ellipsis
        /// - height cố định để các card đều nhau
        /// =========================
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

        /// =========================
        /// PILL "IN WATCHLIST"
        /// - nhấn để remove khỏi watchlist
        /// - có confirm dialog
        /// =========================
        SizedBox(
          height: pillHeight,
          width: double.infinity,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () async {
              /// Hiện dialog xác nhận trước khi xóa.
              final shouldRemove = await showRemoveConfirmDialog(
                context,
                movieTitle: movie.title,
              );

              /// Nếu user xác nhận -> remove item.
              if (shouldRemove == true) {
                await ref
                    .read(watchlistControllerProvider.notifier)
                    .removeItem(movie.id);

                /// Sau khi xóa, hiện snackbar thông báo.
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

                /// Viền đỏ mảnh
                border: Border.all(color: AppColors.error, width: 1.2),

                /// Nền đỏ rất nhạt
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
    );
  }
}
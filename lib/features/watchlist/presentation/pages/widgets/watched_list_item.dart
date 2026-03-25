import 'package:flutter/material.dart';

/// Màu dùng chung từ core.
/// Dùng cho badge rating viền đỏ.
import '../../../../../core/theme/app_colors.dart';

/// Radius dùng chung từ core.
/// Dùng cho bo góc poster.
import '../../../../../core/theme/app_radius.dart';

/// Entity Movie của feature watchlist.
/// Widget này nhận dữ liệu Movie để render UI.
import '../../../domain/entities/movie.dart';

/// Helper format duration / rating
import '../utils/movie_formatters.dart';

/// Component metadata nhỏ
import 'meta_row.dart';

/// =======================================================
/// ITEM CỦA TAB WATCHED
/// - Mỗi item là 1 phim đã xem
/// - Gồm:
///   + poster
///   + title
///   + duration
///   + director
///   + AR / rating
///   + genre
///   + nút trạng thái "Watched"
/// =======================================================
class WatchedListItem extends StatelessWidget {
  final Movie movie;

  const WatchedListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// =========================
        /// PHẦN TRÊN: poster + info
        /// =========================
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// =========================
            /// POSTER
            /// - bo góc
            /// - nếu lỗi ảnh thì show placeholder
            /// =========================
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: SizedBox(
                width: 120,
                height: 170,
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

            const SizedBox(width: 14),

            /// =========================
            /// CỘT THÔNG TIN BÊN PHẢI
            /// - dùng Expanded để chiếm phần còn lại
            /// =========================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Tên phim
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),

                  /// Duration
                  MetaRow(
                    label: 'Duration',
                    value: formatDuration(movie.durationMin),
                  ),
                  const SizedBox(height: 6),

                  /// Director
                  MetaRow(
                    label: 'Director',
                    value: (movie.director?.trim().isNotEmpty ?? false)
                        ? movie.director!
                        : '-',
                  ),
                  const SizedBox(height: 6),

                  /// =========================
                  /// AR / Rating
                  /// - label bên trái
                  /// - badge đỏ bên phải
                  /// =========================
                  Row(
                    children: [
                      const MetaLabelOnly(label: 'AR'),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.error, width: 1),
                          color: Colors.white,
                        ),
                        child: Text(
                          formatRating(movie.rating),
                          style: const TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// =========================
                  /// GENRE
                  /// - join bằng dấu phẩy nếu có nhiều genres
                  /// - dùng Expanded để tránh overflow
                  /// =========================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MetaLabelOnly(label: 'Genre'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          movie.genres.isNotEmpty
                              ? movie.genres.join(', ')
                              : '-',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.45,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        /// =========================
        /// NÚT TRẠNG THÁI "WATCHED"
        /// - chỉ mang tính hiển thị
        /// - không có onTap
        /// - giống 1 button disabled / static
        /// =========================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.black12, width: 1),
            color: Colors.white,
          ),
          child: const Center(
            child: Text(
              'Watched',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
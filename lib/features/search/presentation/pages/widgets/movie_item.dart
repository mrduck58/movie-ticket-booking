import 'package:flutter/material.dart';

import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import '../../../domain/entities/movie.dart';
import '../utils/search_formatters.dart';
  
/// =======================================================
/// ITEM CỦA KẾT QUẢ TÌM KIẾM PHIM
/// - hiển thị:
///   + poster
///   + title
///   + duration
///   + badge status
///   + nút "Đặt vé"
/// =======================================================
class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      /// =========================
      /// POSTER BÊN TRÁI
      /// - nếu lỗi ảnh hoặc không có URL thì hiện placeholder
      /// =========================
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

      /// Tên phim
      title: Text(
        movie.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      /// =========================
      /// SUBTITLE
      /// - duration
      /// - badge trạng thái
      /// =========================
      subtitle: Row(
        children: [
          Text(formatMovieDuration(movie.duration)),
          const SizedBox(width: 6),
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

      /// Nút đặt vé
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: const Text('Đặt vé'),
      ),
    );
  }
}
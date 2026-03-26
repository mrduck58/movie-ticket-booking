import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import '../../../domain/entities/cinema.dart';

/// =======================================================
/// ITEM CỦA KẾT QUẢ TÌM KIẾM RẠP
/// - hiển thị:
///   + icon rạp
///   + tên rạp
///   + địa chỉ / location
///   + nút "Suất chiếu"
///
/// HÀNH VI:
/// - bấm cả item -> vào danh sách phim của rạp
/// - bấm nút "Suất chiếu" -> cũng vào danh sách phim của rạp
/// =======================================================
class CinemaItem extends StatelessWidget {
  final Cinema cinema;

  const CinemaItem({super.key, required this.cinema});

  void _openCinemaMovies(BuildContext context) {
    context.pushNamed(
      'cinema-movies',
      pathParameters: {
        'cinemaId': cinema.id,
      },
      extra: cinema.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _openCinemaMovies(context),

      /// =========================
      /// ICON BOX BÊN TRÁI
      /// =========================
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.movie),
      ),

      /// Tên rạp
      title: Text(
        cinema.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),

      /// Địa chỉ / location
      subtitle: Text(
        cinema.location.isNotEmpty ? cinema.location : 'No location',
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      ),

      /// =========================
      /// NÚT ACTION
      /// =========================
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () => _openCinemaMovies(context),
        child: const Text('Suất chiếu'),
      ),
    );
  }
}
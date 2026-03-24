import 'package:flutter/material.dart';

/// Entity Movie của feature watchlist
import '../../../domain/entities/movie.dart';

/// Widget item riêng của từng phim watched
import 'watched_list_item.dart';

/// =======================================================
/// TAB WATCHED
/// - Hiển thị danh sách phim đã xem
/// - Dùng ListView.separated để:
///   + render list dọc
///   + có khoảng cách cố định giữa các item
/// =======================================================
class WatchedList extends StatelessWidget {
  final List<Movie> items;

  const WatchedList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    /// Empty state khi chưa có phim đã xem.
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No watched items',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return SafeArea(
      top: false,
      child: ListView.separated(
        /// Padding toàn list.
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),

        /// Số lượng item.
        itemCount: items.length,

        /// Khoảng cách giữa 2 item.
        separatorBuilder: (_, __) => const SizedBox(height: 22),

        /// Render từng item watched.
        itemBuilder: (_, i) => WatchedListItem(movie: items[i]),
      ),
    );
  }
}
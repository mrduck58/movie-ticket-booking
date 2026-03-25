import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Entity Movie của feature watchlist
import '../../../domain/entities/movie.dart';

/// Widget item riêng của từng poster card
import 'watchlist_grid_item.dart';

/// =======================================================
/// TAB WATCHLIST
/// - Hiển thị phim theo dạng grid 2 cột
/// - Tính toán childAspectRatio động để:
///   + poster đúng tỉ lệ
///   + title + pill không bị lệch
///   + toàn bộ item đồng đều
/// =======================================================
class WatchlistGrid extends ConsumerWidget {
  final List<Movie> items;

  const WatchlistGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Padding bottom của thiết bị (safe area / home indicator).
    /// Dùng để tránh item cuối bị đè.
    final bottomInset = MediaQuery.of(context).padding.bottom;

    /// Empty state nếu chưa có item watchlist.
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'No watchlist items',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          /// =========================
          /// THÔNG SỐ GRID
          /// =========================

          /// Grid có 2 cột.
          const crossAxisCount = 2;

          /// Khoảng cách ngang giữa các item.
          const crossAxisSpacing = 18.0;

          /// Khoảng cách dọc giữa các item.
          const mainAxisSpacing = 18.0;

          /// Padding toàn grid.
          /// Bottom cộng thêm bottomInset để tránh vướng safe area.
          final padding = EdgeInsets.fromLTRB(18, 18, 18, 28 + bottomInset);

          /// Chiều rộng có thể dùng sau khi trừ padding ngang.
          final gridWidth = constraints.maxWidth - padding.horizontal;

          /// Tính width của từng item.
          final itemWidth =
              (gridWidth - (crossAxisCount - 1) * crossAxisSpacing) /
                  crossAxisCount;

          /// Tính chiều cao poster theo tỉ lệ cố định.
          /// 4.2 / 3.0 là tỉ lệ đang được dùng ở UI hiện tại.
          final posterHeight = itemWidth * (4.2 / 3.0);

          /// =========================
          /// CHIỀU CAO PHẦN CÒN LẠI CỦA ITEM
          /// =========================
          const gap1 = 10.0;
          const titleHeight = 20.0;
          const gap2 = 10.0;
          const pillHeight = 36.0;

          /// Tổng chiều cao card item.
          final itemHeight =
              posterHeight + gap1 + titleHeight + gap2 + pillHeight;

          /// childAspectRatio = width / height
          /// GridView dùng tỉ lệ này để render item đúng form.
          final childAspectRatio = itemWidth / itemHeight;

          return Padding(
            padding: padding,
            child: GridView.builder(
              itemCount: items.length,
              padding: EdgeInsets.zero,

              /// Grid delegate quyết định:
              /// - số cột
              /// - spacing
              /// - tỉ lệ item
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,

                /// Tạm để 1 trong const delegate,
                /// sau đó override bằng copyWith bên dưới.
                childAspectRatio: 1,
              ).copyWith(
                childAspectRatio: childAspectRatio,
              ),

              /// Render từng card watchlist.
              itemBuilder: (_, i) => WatchlistGridItem(
                movie: items[i],
                posterHeight: posterHeight,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// =======================================================
/// EXTENSION CHO SliverGridDelegateWithFixedCrossAxisCount
/// - Flutter không có sẵn copyWith cho delegate này
/// - Tạo extension để sửa mỗi childAspectRatio mà không phải viết lại toàn bộ
/// =======================================================
extension on SliverGridDelegateWithFixedCrossAxisCount {
  SliverGridDelegateWithFixedCrossAxisCount copyWith({
    int? crossAxisCount,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    double? childAspectRatio,
    double? mainAxisExtent,
  }) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      childAspectRatio: childAspectRatio ?? this.childAspectRatio,
      mainAxisExtent: mainAxisExtent ?? this.mainAxisExtent,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Màu dùng chung từ core.
/// Ở đây dùng AppColors.error để giữ đúng màu đỏ cho tab đang active.
import '../../../../../core/theme/app_colors.dart';

/// Provider quản lý state của watchlist / watched.
/// Screen này chỉ watch state và render UI tương ứng.
import '../../providers/watchlist_providers.dart';

/// Widget tab Watchlist (grid poster)
import '../widgets/watchlist_grid.dart';

/// Widget tab Watched (list dọc)
import '../widgets/watched_list.dart';

/// =======================================================
/// MÀN HÌNH CHÍNH: WatchlistWatchedScreen
/// - Là màn hình chứa 2 tab:
///   1. Watchlist
///   2. Watched
///
/// Dùng ConsumerStatefulWidget vì:
/// - cần đọc state Riverpod qua ref
/// - cần giữ TabController như state nội bộ
/// =======================================================
class WatchlistWatchedScreen extends ConsumerStatefulWidget {
  const WatchlistWatchedScreen({super.key});

  @override
  ConsumerState<WatchlistWatchedScreen> createState() =>
      _WatchlistWatchedScreenState();
}

/// =======================================================
/// STATE của WatchlistWatchedScreen
/// - SingleTickerProviderStateMixin để cung cấp vsync
///   cho TabController
/// - TabController quản lý việc chuyển giữa 2 tab
/// =======================================================
class _WatchlistWatchedScreenState extends ConsumerState<WatchlistWatchedScreen>
    with SingleTickerProviderStateMixin {
  /// Controller điều khiển TabBar + TabBarView
  late final TabController _tab;

  @override
  void initState() {
    super.initState();

    /// Khởi tạo controller với đúng 2 tab.
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    /// Luôn dispose controller để tránh memory leak.
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Lắng nghe state từ Riverpod.
    /// vm thường là AsyncValue<WatchlistState>.
    final vm = ref.watch(watchlistControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,

      /// =========================
      /// APP BAR
      /// - tiêu đề
      /// - nút back
      /// - tab bar ở bottom
      /// =========================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,

        /// Nút back quay lại màn trước.
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),

        /// Tiêu đề màn.
        title: const Text(
          'Watchlist',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),

        /// Bottom của AppBar chứa TabBar.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: Column(
            children: [
              TabBar(
                controller: _tab,

                /// Màu chữ tab đang được chọn.
                labelColor: AppColors.error,

                /// Màu chữ tab chưa được chọn.
                unselectedLabelColor: Colors.grey,

                /// Style chữ của tab.
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),

                /// Màu thanh indicator dưới tab active.
                indicatorColor: AppColors.error,

                /// Độ dày indicator.
                indicatorWeight: 2,

                /// Indicator chiếm full chiều rộng tab.
                indicatorSize: TabBarIndicatorSize.tab,

                /// Danh sách tab.
                tabs: const [
                  Tab(text: 'Watchlist'),
                  Tab(text: 'Watched'),
                ],
              ),

              /// Đường line mỏng dưới tab để tách UI.
              Container(height: 1, color: Colors.grey.shade200),
            ],
          ),
        ),
      ),

      /// =========================
      /// BODY
      /// - render theo 3 trạng thái AsyncValue:
      ///   + loading
      ///   + error
      ///   + data
      /// =========================
      body: vm.when(
        /// Khi đang load dữ liệu.
        loading: () => const Center(child: CircularProgressIndicator()),

        /// Khi có lỗi.
        error: (e, st) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Error: $e',
              textAlign: TextAlign.center,
            ),
          ),
        ),

        /// Khi load data thành công.
        data: (data) => TabBarView(
          controller: _tab,
          children: [
            /// Tab 1: Watchlist dạng grid.
            WatchlistGrid(items: data.watchlist),

            /// Tab 2: Watched dạng list.
            WatchedList(items: data.watched),
          ],
        ),
      ),
    );
  }
}
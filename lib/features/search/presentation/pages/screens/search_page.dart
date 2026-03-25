import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import '../../providers/search_provider.dart';
import '../widgets/cinema_item.dart';
import '../widgets/movie_item.dart';
import '../widgets/search_header.dart';
import '../widgets/search_tab.dart';

/// =======================================================
/// MÀN HÌNH SEARCH
/// - Cho phép nhập từ khoá để tìm:
///   + Rạp
///   + Phim
///
/// Dùng ConsumerStatefulWidget vì:
/// - cần đọc state từ Riverpod
/// - cần giữ state nội bộ:
///   + tabIndex
///   + TextEditingController
///   + debounce timer
/// =======================================================
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  /// Tab đang được chọn:
  /// 0 -> Rạp
  /// 1 -> Phim
  int tabIndex = 0;

  /// Controller cho ô search input
  final _controller = TextEditingController();

  /// Timer dùng để debounce khi user gõ từ khoá
  Timer? _debounce;

  @override
  void dispose() {
    /// Luôn huỷ timer và dispose controller để tránh leak
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// =======================================================
  /// XỬ LÝ KHI KEYWORD THAY ĐỔI
  /// - dùng debounce 400ms để tránh gọi search liên tục
  /// - sau khi user ngừng gõ 1 chút mới trigger search
  /// =======================================================
  void _onKeywordChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(searchControllerProvider.notifier).search(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Lắng nghe state từ Riverpod
    final vm = ref.watch(searchControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: vm.when(
          /// =========================
          /// LOADING
          /// - vẫn giữ header ở trên
          /// - body hiện progress
          /// =========================
          loading: () => Column(
            children: [
              SearchHeader(
                controller: _controller,
                onChanged: _onKeywordChanged,
              ),
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          ),

          /// =========================
          /// ERROR
          /// - vẫn giữ header
          /// - body hiện text lỗi
          /// =========================
          error: (e, _) => Column(
            children: [
              SearchHeader(
                controller: _controller,
                onChanged: _onKeywordChanged,
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      e.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// =========================
          /// DATA
          /// - render theo keyword + tab + kết quả
          /// =========================
          data: (state) {
            final keyword = state.keyword;

            return Column(
              children: [
                /// Header search luôn nằm trên cùng
                SearchHeader(
                  controller: _controller,
                  onChanged: _onKeywordChanged,
                ),

                /// Chỉ hiện tab khi đã có keyword
                if (keyword.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SearchTab(
                        text: 'Rạp',
                        active: tabIndex == 0,
                        onTap: () {
                          setState(() => tabIndex = 0);
                        },
                      ),
                      const SizedBox(width: 10),
                      SearchTab(
                        text: 'Phim',
                        active: tabIndex == 1,
                        onTap: () {
                          setState(() => tabIndex = 1);
                        },
                      ),
                    ],
                  ),

                const SizedBox(height: 10),

                /// =========================
                /// TRẠNG THÁI BODY
                /// 1. Chưa nhập keyword
                /// 2. Có keyword nhưng không có kết quả
                /// 3. Có dữ liệu -> hiện list
                /// =========================
                if (keyword.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Enter keyword to find cinema or movie',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                else if (state.isEmptyResult)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Không tìm thấy kết quả',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),

                      /// Nếu tabIndex = 0 -> list cinema
                      /// Nếu tabIndex = 1 -> list movie
                      child: tabIndex == 0
                          ? ListView.builder(
                              itemCount: state.cinemas.length,
                              itemBuilder: (_, i) {
                                final c = state.cinemas[i];
                                return CinemaItem(cinema: c);
                              },
                            )
                          : ListView.builder(
                              itemCount: state.movies.length,
                              itemBuilder: (_, i) {
                                final m = state.movies[i];
                                return MovieItem(movie: m);
                              },
                            ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
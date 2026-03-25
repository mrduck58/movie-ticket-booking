import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import '../../providers/search_provider.dart';

/// =======================================================
/// HEADER CỦA MÀN SEARCH
/// - gồm:
///   + ô nhập từ khoá
///   + nút "Huỷ"
///
/// Tách riêng để:
/// - screen chính gọn hơn
/// - dễ tái sử dụng / chỉnh riêng phần header
/// =======================================================
class SearchHeader extends ConsumerWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchHeader({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          /// =========================
          /// SEARCH INPUT
          /// - chiếm toàn bộ phần rộng còn lại
          /// - có icon search
          /// - nền trắng, bo tròn
          /// =========================
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onChanged,
            ),
          ),

          const SizedBox(width: 12),

          /// =========================
          /// NÚT HUỶ
          /// - clear state search
          /// - quay về trang chủ
          /// =========================
          GestureDetector(
            onTap: () {
              ref.read(searchControllerProvider.notifier).clear();
              context.go('/');
            },
            child: const Text(
              'Huỷ',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
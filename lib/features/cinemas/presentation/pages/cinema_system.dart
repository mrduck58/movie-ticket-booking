import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../domain/entities/cinema.dart';
import '../providers/cinema_providers.dart'; // Đảm bảo đúng file chứa allCinemasProvider
import '../../data/models/cineme_tab.dart';

import '../widgets/cinema_tab.dart';
import '../widgets/cinema_tile.dart';
import '../widgets/location_row.dart';

class CinemaSystemPage extends ConsumerStatefulWidget {
  const CinemaSystemPage({super.key});

  @override
  ConsumerState<CinemaSystemPage> createState() => _CinemaSystemPageState();
}

// ... các phần import giữ nguyên

class _CinemaSystemPageState extends ConsumerState<CinemaSystemPage> {
  CinemaTab tab = CinemaTab.all;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<Cinema>>>(allCinemasProvider, (previous, next) {
      next.whenData((cinemas) {
        ref.read(favoriteCinemasProvider.notifier).initFrom(cinemas);
      });
    });

    final cinemasAsync = ref.watch(allCinemasProvider);
    final favoriteIds = ref.watch(favoriteCinemasProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              // Luôn quay về Home khi bấm nút back
              onPressed: () => context.go('/'),
            ),
            title: const Text(
              "Cinema System",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),
      body: cinemasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: ${e.toString()}")),
        data: (cinemas) {
          final list = _filter(cinemas, favoriteIds);

          return Column(
            children: [
              const LocationRow(),
              const Divider(
                height: 2,
                indent: AppSpacing.pagePadding,
                endIndent: AppSpacing.pagePadding,
              ),
              const SizedBox(height: 16),
              CinemaTabs(tab: tab, onChanged: (t) => setState(() => tab = t)),
              const Divider(
                height: 2,
                indent: AppSpacing.pagePadding,
                endIndent: AppSpacing.pagePadding,
              ),
              
              // CHỈNH SỬA TẠI ĐÂY: Đưa check empty vào trong Expanded
              Expanded(
                child: list.isEmpty
                    ? _buildEmptyState() // Gọi hàm hiển thị thông báo trống
                    : ListView.separated(
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 2,
                          indent: AppSpacing.pagePadding,
                          endIndent: AppSpacing.pagePadding,
                        ),
                        itemBuilder: (context, index) {
                          final cinema = list[index];
                          final isFav = favoriteIds.contains(cinema.id);
                          return CinemaTile(
                            cinema: cinema,
                            isFavorite: isFav,
                            onFavoriteToggle: () {
                              ref.read(favoriteCinemasProvider.notifier).toggle(cinema.id);
                            },
                            onTap: () {
                              context.push(
                                '/cinema-movies/${cinema.id}',
                                extra: cinema.name,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget hiển thị khi không có rạp nào (Empty State)
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie_filter_outlined, size: 80, color: Colors.grey.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            tab == CinemaTab.favorites 
                ? "You haven't added any favorite cinemas yet" 
                : "No cinemas available",
            style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Nút bấm quay về Home hoặc đổi sang Tab All cho tiện
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              if (tab == CinemaTab.favorites) {
                setState(() => tab = CinemaTab.all);
              } else {
                context.go('/');
              }
            },
            child: Text(tab == CinemaTab.favorites ? "Show All Cinemas" : "Back to Home"),
          ),
        ],
      ),
    );
  }

  List<Cinema> _filter(List<Cinema> cinemas, Set<String> favorites) {
    if (tab == CinemaTab.favorites) {
      return cinemas.where((e) => favorites.contains(e.id)).toList();
    }
    return cinemas;
  }
}
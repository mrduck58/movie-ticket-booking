import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../../../../domain/entities/cinema.dart';
import '../providers/cinema_providers.dart';
import '../../data/models/cineme_tab.dart';
import '../../../../features/checkout/providers/booking_draft_provider.dart';
import '../../../../features/home/presentation/providers/home_providers.dart';

import '../widgets/cinema_tab.dart';
import '../widgets/cinema_tile.dart';
import '../widgets/location_row.dart';

class ChooseCinemaPage extends ConsumerStatefulWidget {
  final String movieId;

  const ChooseCinemaPage({super.key, required this.movieId});

  @override
  ConsumerState<ChooseCinemaPage> createState() => _ChooseCinemaPageState();
}

class _ChooseCinemaPageState extends ConsumerState<ChooseCinemaPage> {
  CinemaTab tab = CinemaTab.all;

  @override
  Widget build(BuildContext context) {
    final cinemasAsync = ref.watch(cinemasProvider);
    final favoriteIds = ref.watch(favoriteCinemasProvider);
    final moviesAsync = ref.watch(movieProvider);

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
              onPressed: () => context.pop(),
            ),
            title: const Text(
              "Choose Cinema",
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
        error: (e, _) => Center(child: Text(e.toString())),
        data: (cinemas) {
          //ref.read(favoriteCinemasProvider.notifier).initFrom(cinemas);

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

              Expanded(
                child: ListView.separated(
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
                        ref
                            .read(favoriteCinemasProvider.notifier)
                            .toggle(cinema.id);
                      },
                      onTap: () {
                        final movies = moviesAsync.value;
                        if (movies != null) {
                          final movie = movies.firstWhere(
                            (m) => m.id == widget.movieId,
                            orElse: () => movies.first,
                          );
                          final booking = ref.read(bookingDraftProvider.notifier);

                          booking.setMovie(movie.toEntity());
                          booking.setCinema(cinema);

                          context.push(
                            '/showtimes/${widget.movieId}/${cinema.id}',
                          );
                        }
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

  List<Cinema> _filter(List<Cinema> cinemas, Set<String> favorites) {
    if (tab == CinemaTab.favorites) {
      return cinemas.where((e) => favorites.contains(e.id)).toList();
    }
    return cinemas;
  }
}

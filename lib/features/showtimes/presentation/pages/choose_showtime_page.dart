import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/features/cinemas/presentation/providers/cinema_providers.dart';
import 'package:movie_ticket_booking/features/showtimes/presentation/widgets/date_picker.dart';

import '../../../checkout/providers/booking_draft_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters/date_formatter.dart';

import '../providers/showtime_providers.dart';
import '../widgets/showtime_section.dart';
import '../../data/models/selected_showtime.dart';

class ChooseShowtimePage extends ConsumerWidget {
  final String cinemaId;
  final String movieId;

  const ChooseShowtimePage({
    super.key,
    required this.cinemaId,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);

    final cinemaAsync = ref.watch(cinemaProvider(cinemaId));

    final showtimesAsync = ref.watch(
      showtimesProvider((
        movieId: movieId,
        cinemaId: cinemaId,
        date: selectedDate,
      )),
    );

    final selectedTime = ref.watch(selectedShowtimeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Choose Date and Time",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: showtimesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (showtimes) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            children: [
              // MAP IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/maps/map_mock.jpg",
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              cinemaAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text(e.toString()),
                data: (cinema) => Text(
                  cinema.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              cinemaAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text(e.toString()),
                data: (cinema) => Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 18),
                    const SizedBox(width: 6),
                    Text(cinema.rating),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              cinemaAsync.when(
                data: (cinema) => Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 6),
                    Expanded(child: Text(cinema.location)),
                  ],
                ),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              ),

              const SizedBox(height: 6),

              cinemaAsync.when(
                data: (cinema) => Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 18),
                    const SizedBox(width: 6),
                    Text("+${cinema.hotline}"),
                  ],
                ),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              ),

              const SizedBox(height: 24),

              const DatePickerBar(),

              const SizedBox(height: 16),

              ...showtimes.map((group) => ShowtimeSection(group: group)),
            ],
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size.fromHeight(56),
          ),
          onPressed: selectedTime == null
              ? null
              : () {
                  final selectedDate = ref.read(selectedDateProvider);
                  final formattedDate = DateFormatter.date(selectedDate);

                  ref
                      .read(bookingDraftProvider.notifier)
                      .setShowtime(
                        selectedTime.showtime,
                        date: formattedDate,
                        auditorium: selectedTime.showtime.roomName,
                      );

                  context.push(
                    '/seat-selection/$movieId/$cinemaId/${selectedTime.showtime.showtimeId}',
                  );
                },
          child: const Text(
            "Continue",
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

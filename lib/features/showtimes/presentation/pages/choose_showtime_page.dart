import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/showtimes/presentation/widgets/date_picker.dart';

import '../../../checkout/providers/booking_draft_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

import '../providers/showtime_providers.dart';
import '../widgets/showtime_section.dart';

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
    final showtimesAsync = ref.watch(showtimesProvider(cinemaId));

    final selectedTime = ref.watch(selectedShowtimeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            //Navigator.pop(context);
          },
        ),
        title: const Text(
          "Choose Cinema",
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

              Text(
                "Name movie",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 18),
                  SizedBox(width: 6),
                  Text("4.1 (10,771 Google reviews)"),
                ],
              ),

              const SizedBox(height: 8),

              const Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 18),
                  SizedBox(width: 6),
                  Expanded(child: Text("234 W 42nd St, New York")),
                ],
              ),

              const SizedBox(height: 6),

              const Row(
                children: [
                  Icon(Icons.phone_outlined, size: 18),
                  SizedBox(width: 6),
                  Text("+1 212-398-2597"),
                ],
              ),

              const SizedBox(height: 24),

              const DatePickerBar(),

              const SizedBox(height: 16),

              ...showtimes.map((s) => ShowtimeSection(showtime: s)),
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
                  ref.read(bookingDraftProvider.notifier).state = ref
                      .read(bookingDraftProvider)!
                      .copyWith(cinemaId: cinemaId, showtime: selectedTime);
                  context.go(
                    '/seat-selection/$movieId/$cinemaId/$selectedTime',
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

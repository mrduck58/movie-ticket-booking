import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/core/theme/app_spacing.dart';

import '../../../checkout/providers/booking_draft_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters/money_formatter.dart';

import '../providers/seat_providers.dart';
import '../widgets/seat_grid.dart';
import '../widgets/screen_curve.dart';
import '../widgets/seat_legend.dart';

class SeatSelectionPage extends ConsumerWidget {
  final String movieId;
  final String cinemaId;
  final String showtimeId;

  const SeatSelectionPage({
    super.key,
    required this.movieId,
    required this.cinemaId,
    required this.showtimeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seatsAsync = ref.watch(seatMapProvider(showtimeId));
    final selectedSeats = ref.watch(selectedSeatsProvider);
    final draft = ref.watch(bookingDraftProvider);

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
              "Choose Seat(s)",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),

      body: seatsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),

        data: (seatMap) {
          double ticketPrice = draft.showtime?.price ?? 0;
          final price = selectedSeats.length * ticketPrice;

          return Column(
            children: [
              const ScreenCurve(),

              const SizedBox(height: 20),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(child: SeatGrid(seats: seatMap.seats)),

                      const SizedBox(height: 12),

                      const SeatLegend(),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
                indent: AppSpacing.pagePadding,
                endIndent: AppSpacing.pagePadding,
              ),

              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Total price",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  MoneyFormatter.vnd(price),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const VerticalDivider(
                            width: 8,
                            thickness: 2,
                            color: AppColors.textTertiary,
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Seat(s)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: selectedSeats
                                      .map(
                                        (e) => Chip(
                                          label: Text(
                                            e.seatName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: AppColors.primary,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size.fromHeight(56),
                        ),
                        onPressed: selectedSeats.isEmpty
                            ? null
                            : () {
                                final booking = ref.read(
                                  bookingDraftProvider.notifier,
                                );

                                booking.setSeats(selectedSeats);

                                context.push('/review');
                              },
                        child: const Text(
                          "Continue",
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

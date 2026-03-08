import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';

import '../../../checkout/providers/booking_draft_provider.dart';

import '../widgets/movie_info_section.dart';
import '../widgets/booking_details_section.dart';
import '../widgets/price_details_section.dart';

class ReviewSummaryPage extends ConsumerWidget {
  const ReviewSummaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demoDraft = BookingDraft(
      movieId: "DEADPOOL 3",
      cinemaId: "AMC Empire 25",
      showtime: "17:30 - 20:38",
      seats: ["F6", "F7", "F8", "F9"],
    );

    final draft = ref.watch(bookingDraftProvider) ?? demoDraft;

    //final price = draft.seats.length * 12;

    final ticketPrice = 50000;
    final ticketCount = draft.seats.length;
    final comboPrice = 198000;
    final voucher = 0;

    final total = ticketPrice * ticketCount + comboPrice - voucher;

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
              onPressed: () {},
            ),
            title: const Text(
              "Review Summary",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [
            MovieInfoSection(
              title: draft.movieId, // demo
            ),

            const SizedBox(height: 16),

            BookingDetailsSection(
              cinema: draft.cinemaId ?? "-",
              auditorium: "Auditorium 3",
              seats: draft.seats,
              date: "5 Mar",
              hours: draft.showtime ?? "-",
            ),

            const SizedBox(height: 16),

            PriceDetailsSection(
              ticketPrice: ticketPrice,
              ticketCount: ticketCount,
              comboPrice: comboPrice,
              voucher: voucher,
              total: total,
            ),

            const SizedBox(height: 20),

            Text("Promo & Vouchers", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                hintText: "Enter the promo code or voucher",
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  context.go('/payment-method');
                },
                child: const Text(
                  "Continue to Payment",
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

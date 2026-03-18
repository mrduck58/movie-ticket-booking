import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters/money_formatter.dart';

import '../../../checkout/providers/booking_draft_provider.dart';
import '../providers/combo_provider.dart';
import '../providers/voucher_provider.dart';

import '../widgets/movie_info_section.dart';
import '../widgets/booking_details_section.dart';
import '../widgets/price_details_section.dart';
import '../widgets/combo_section.dart';
import '../widgets/transaction_detail_section.dart';

class BookingDetailPage extends ConsumerWidget {
  const BookingDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(bookingDraftProvider);

    final seats = draft.seats;
    final ticketCount = seats.length;

    final ticketPrice = draft.showtime?.price ?? 12;
    final ticketTotal = ticketCount * ticketPrice;

    final selectedCombos = ref.watch(selectedCombosProvider);
    final combos = ref.watch(combosProvider).value ?? [];

    final selectedVoucher = ref.watch(selectedVoucherProvider);
    final voucherDiscount = selectedVoucher?.discount ?? 0;

    int comboTotal = 0;

    for (final combo in combos) {
      final qty = selectedCombos[combo.id] ?? 0;
      comboTotal += combo.price * qty;
    }

    final total = ticketTotal + comboTotal - voucherDiscount;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Booking Details",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [
            /// Movie info
            MovieInfoSection(
              title: draft.movie?.title ?? "-",
              duration: draft.movie?.durationMin.toString() ?? "-",
              director: draft.movie?.director ?? "-",
              rating: draft.movie?.rating?.toString() ?? "-",
              genre: draft.movie?.genres?.join(", ") ?? "-",
              poster: draft.movie?.posterUrl ?? "assets/mock/movie.jpg",
            ),

            const SizedBox(height: 16),

            /// Booking details
            BookingDetailsSection(
              durationMin: draft.movie?.durationMin.toString() ?? "-",
              cinema: draft.cinema?.name ?? "-",
              auditorium: draft.auditorium ?? "-",
              seats: draft.seats
                  .map((s) => s.row + s.number.toString())
                  .toList(),
              date: draft.date ?? "-",
              hours: draft.showtime?.times.first ?? "-",
            ),

            const SizedBox(height: 16),

            /// Combo (read only)
            ComboSection(readOnly: true),

            const SizedBox(height: 16),

            /// Price
            PriceDetailsSection(
              ticketPrice: ticketPrice.toInt(),
              ticketCount: ticketCount,
              comboPrice: comboTotal,
              voucher: voucherDiscount.toInt(),
              total: total.toInt(),
            ),

            const SizedBox(height: 16),

            /// Transaction Details
            TransactionDetailsSection(totalPrice: total.toInt()),

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
                  final draft = ref.read(bookingDraftProvider);

                  ref.read(bookingDraftProvider.notifier).state = draft
                      .copyWith(totalPrice: total.toInt());

                  context.go('/my-ticket');
                },
                child: const Text(
                  "View My Ticket",
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),
                onPressed: () {
                  final draft = ref.read(bookingDraftProvider);

                  ref.read(bookingDraftProvider.notifier).state = draft
                      .copyWith(totalPrice: total.toInt());

                  context.go('/');
                },
                child: const Text(
                  "Back to Home",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import 'package:movie_ticket_booking/core/utils/formatters/money_formatter.dart';

import '../../../checkout/providers/booking_draft_provider.dart';

import '../providers/combo_provider.dart';
import '../providers/voucher_provider.dart';

import '../widgets/movie_info_section.dart';
import '../widgets/booking_details_section.dart';
import '../widgets/price_details_section.dart';
import '../widgets/combo_section.dart';
import '../widgets/voucher_bottomsheet.dart';

class ReviewSummaryPage extends ConsumerWidget {
  const ReviewSummaryPage({super.key});

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
              title: draft.movie?.title ?? "-",
              duration: draft.movie?.duration ?? "-",
              director: draft.movie?.director ?? "-",
              rating: draft.movie?.rating?.toString() ?? "-",
              genre: draft.movie?.genres?.join(", ") ?? "-",
              poster: draft.movie?.posterUrl ?? "assets/mock/movie.jpg",
            ),

            const SizedBox(height: 16),

            BookingDetailsSection(
              durationMin: draft.movie?.duration ?? "",
              cinema: draft.cinema?.name ?? "-",
              auditorium: draft.auditorium ?? "Auditorium 3",
              seats: draft.seats
                  .map((s) => s.row + s.number.toString())
                  .toList(),
              date: draft.date ?? "5 Mar",
              hours: draft.showtime?.times.first ?? "-", // assuming first time
            ),

            const SizedBox(height: 16),

            const ComboSection(),

            const SizedBox(height: 16),

            Text(
              "Promo & Vouchers",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                hintText: "Enter the promo code or voucher",
                labelStyle: TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),

            // ListTile(
            //   title: const Text(
            //     "Promo & Vouchers",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //   ),

            //   subtitle: selectedVoucher == null
            //       ? const Text("Select voucher")
            //       : Text(
            //           "${selectedVoucher.code} (-${MoneyFormatter.vnd(selectedVoucher.discount)})",
            //         ),

            //   trailing: const Icon(Icons.arrow_forward_ios),

            //   onTap: () {
            //     showModalBottomSheet(
            //       context: context,

            //       shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.vertical(
            //           top: Radius.circular(20),
            //         ),
            //       ),

            //       builder: (_) => const VoucherBottomSheet(),
            //     );
            //   },
            // ),
            const SizedBox(height: 20),

            PriceDetailsSection(
              ticketPrice: ticketPrice.toInt(),
              ticketCount: ticketCount,
              comboPrice: comboTotal,
              voucher: selectedVoucher?.discount.toInt() ?? 0,
              total: total.toInt(),
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
                  final draft = ref.read(bookingDraftProvider);

                  ref.read(bookingDraftProvider.notifier).state = draft
                      .copyWith(totalPrice: total.toInt());

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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/review/presentation/providers/booking_success_provider.dart';
import 'package:movie_ticket_booking/features/ticket/domain/entities/ticket.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../checkout/providers/booking_draft_provider.dart';
import '../../../food_combo/presentation/providers/combo_provider.dart';
import '../../../payment/presentation/providers/checkout_provider.dart';
import '../../../seat_selection/presentation/providers/seat_providers.dart';
import '../providers/booking_expiry_provider.dart';
import '../providers/voucher_provider.dart';

import '../widgets/movie_info_section.dart';
import '../widgets/booking_details_section.dart';
import '../widgets/combo_section.dart';
import '../widgets/price_details_section.dart';
import '../widgets/transaction_detail_section.dart';

class BookingDetailPage extends ConsumerWidget {
  final String bookingId;
  const BookingDetailPage({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(bookingDraftProvider);
    final flow = ref.watch(paymentFlowProvider);

    final seats = draft.seats;
    final ticketCount = seats.length;
    final ticketPrice = draft.showtime?.price ?? 0;
    final ticketTotal = ticketCount * ticketPrice;

    final selectedCombos = ref.watch(selectedCombosProvider);
    final combos = ref.watch(combosProvider).value ?? [];
    int comboTotal = 0;
    for (final combo in combos) {
      final qty = selectedCombos[combo.id] ?? 0;
      comboTotal += combo.price * qty;
    }

    final selectedVoucher = ref.watch(selectedVoucherProvider);
    double voucherDiscount = 0;
    if (selectedVoucher != null) {
      if (selectedVoucher.type == "PERCENTAGE") {
        voucherDiscount =
            (ticketTotal + comboTotal) * selectedVoucher.discountValue / 100;
      } else if (selectedVoucher.type == "FIX_AMOUNT") {
        voucherDiscount = selectedVoucher.discountValue;
      }
    }

    final total = ticketTotal + comboTotal - voucherDiscount;

    void clearAndGo(String path) {
      ref.read(bookingDraftProvider.notifier).reset();
      ref.read(selectedSeatsProvider.notifier).clear();
      ref.read(selectedCombosProvider.notifier).clear();
      ref.read(paymentFlowProvider.notifier).reset();
      ref.read(selectedVoucherProvider.notifier).state = null;
      ref.read(bookingExpiryProvider.notifier).resetTimer();
      context.go(path);
    }


    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Booking Details',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Movie Info ──────────────────────────────────────
          if (draft.movie != null) ...[
            MovieInfoSection(
              title: draft.movie!.title,
              duration: draft.movie!.durationMin.toString(),
              director: draft.movie!.director,
              rating: draft.movie!.rating.toString(),
              genre: draft.movie!.genres.map((g) => g.name).join(", "),
              poster:
                  draft.movie?.posterUrl ?? "https://via.placeholder.com/150",
            ),
            const SizedBox(height: 16),
          ],

          // ── Booking Information ─────────────────────────────
          BookingDetailsSection(
            cinema: draft.cinema?.name ?? "-",
            roomName: draft.auditorium ?? draft.showtime?.roomName ?? "-",
            package: draft.package ?? "-",
            seats: draft.seats.map((s) => '${s.row}${s.number}').toList(),
            date: draft.date ?? "-",
            startTime: draft.showtime?.startTime ?? DateTime.now(),
            durationMin: draft.movie?.durationMin.toDouble() ?? 0.0,
          ),

          const SizedBox(height: 16),

          // ── Combos ──────────────────────────────────────────
          if (comboTotal > 0) ...[
            const ComboSection(),
            const SizedBox(height: 16),
          ],

          // ── Price Details ───────────────────────────────────
          PriceDetailsSection(
            ticketPrice: ticketPrice.toInt(),
            ticketCount: ticketCount,
            comboPrice: comboTotal,
            voucher: voucherDiscount.toInt(),
            total: total.toInt(),
            voucherType: selectedVoucher?.type,
          ),

          const SizedBox(height: 16),

          // ── Transaction Details ─────────────────────────────
          TransactionDetailsSection(
            totalPrice: flow.orderCode != null ? total.toInt() : 0,
            bookingId: bookingId,
            paymentMethod: draft.paymentMethod ?? 'PayOS',
          ),

          const SizedBox(height: 28),

          // ── View Ticket button ──────────────────────────────
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: () async {
                final orderCode = int.tryParse(bookingId);
                if (orderCode == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid order code: $bookingId')),
                  );
                  return;
                }

                // Show loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(child: CircularProgressIndicator()),
                );

                try {
                  // Force a fresh fetch of the final booking status (with QR codes)
                  final bookingData = await ref.refresh(bookingSuccessProvider(orderCode).future);
                  
                  // Debug print (optional, helpful for dev)
                  debugPrint('DEBUG: Received ${bookingData.tickets.length} tickets with QR codes.');
                  for(var t in bookingData.tickets) {
                    debugPrint('DEBUG: Slot ${t.seatName} QR: ${t.qrCode}');
                  }
                  
                  // Pop loading
                  if (context.mounted) Navigator.pop(context);

                  final myTicket = Ticket(
                    title: draft.movie?.title ?? 'Movie',
                    poster: draft.movie?.posterUrl ?? '',
                    startTime: draft.showtime?.startTime ?? DateTime.now(),
                    endTime: (draft.showtime?.startTime ?? DateTime.now()).add(
                        Duration(minutes: draft.movie?.durationMin ?? 0)),
                    cinema: draft.cinema?.name ?? '',
                    room: draft.auditorium ?? draft.showtime?.roomName ?? '',
                    seats: bookingData.tickets.map((t) => t.seatName).toList(),
                    duration: draft.movie?.durationMin ?? 0,
                    rating: draft.movie?.rating ?? 0,
                    genres: draft.movie?.genres.map((g) => g.name).toList() ?? [],
                    qrDatas: bookingData.tickets.map((t) => t.qrCode).toList(),
                  );

                  if (context.mounted) {
                    context.push('/ticket-detail', extra: myTicket);
                  }
                } catch (e) {
                  // Pop loading if still there
                  if (context.mounted) Navigator.pop(context);
                  
                  // Show error
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error loading ticket: $e')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'View My Tickets',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── Back to Home button ─────────────────────────────
          SizedBox(
            height: 54,
            child: OutlinedButton(
              onPressed: () => clearAndGo('/'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

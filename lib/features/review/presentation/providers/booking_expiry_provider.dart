import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft_provider.dart';
import 'package:movie_ticket_booking/features/review/data/models/booking_expiry_state.dart';
import 'package:movie_ticket_booking/features/review/presentation/providers/voucher_provider.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/providers/combo_provider.dart';
import 'package:movie_ticket_booking/features/seat_selection/presentation/providers/seat_providers.dart';
import 'package:movie_ticket_booking/features/payment/presentation/providers/payment_providers.dart';



final bookingExpiryProvider =
    StateNotifierProvider<BookingExpiryNotifier, BookingExpiryState>(
  (ref) => BookingExpiryNotifier(ref),
);

class BookingExpiryNotifier extends StateNotifier<BookingExpiryState> {
  final Ref ref;
  Timer? _timer;

  BookingExpiryNotifier(this.ref) : super(BookingExpiryState.initial());

  void start({Duration duration = const Duration(minutes: 5)}) {
    // nếu đang chạy rồi thì không start lại
    if (state.isRunning && !state.isExpired) return;

    final now = DateTime.now();
    final expiresAt = now.add(duration);

    state = BookingExpiryState(
      startedAt: now,
      expiresAt: expiresAt,
      remaining: duration,
      isRunning: true,
      isExpired: false,
    );

    _startTicking();
  }

  void _startTicking() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final expiresAt = state.expiresAt;
      if (expiresAt == null) return;

      final diff = expiresAt.difference(DateTime.now());

      if (diff.inSeconds <= 0) {
        expireNow();
      } else {
        state = state.copyWith(
          remaining: diff,
          isRunning: true,
          isExpired: false,
        );
      }
    });
  }

  void expireNow() {
    _timer?.cancel();

    state = state.copyWith(
      remaining: Duration.zero,
      isRunning: false,
      isExpired: true,
    );

    clearBookingData();
  }

  void clearBookingData() {
    ref.read(bookingDraftProvider.notifier).reset();

    // reset selected seats
    ref.read(selectedSeatsProvider.notifier).state = [];

    // reset selected combos
    ref.read(selectedCombosProvider.notifier).state = {};

    // reset selected payment
    ref.read(selectedPaymentProvider.notifier).state = null;

    // reset voucher
    ref.read(selectedVoucherProvider.notifier).state = null;
  }

  void resetTimer() {
    _timer?.cancel();
    state = BookingExpiryState.initial();
  }

  String formattedTime() {
    final totalSeconds = state.remaining.inSeconds;
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
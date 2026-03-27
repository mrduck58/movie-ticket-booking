import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft_provider.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/providers/combo_provider.dart';
import 'package:movie_ticket_booking/features/payment/presentation/providers/payment_providers.dart';
import 'package:movie_ticket_booking/features/review/presentation/providers/booking_expiry_provider.dart';
import 'package:movie_ticket_booking/features/seat_selection/presentation/providers/seat_providers.dart';
import '../../../../core/theme/app_colors.dart';

class PaymentSuccessDialog extends ConsumerWidget {
  const PaymentSuccessDialog({super.key});

  void _clearBookingFlow(WidgetRef ref) {
    ref.read(bookingDraftProvider.notifier).reset();
    ref.read(selectedPaymentProvider.notifier).state = null;
    ref.read(selectedSeatsProvider.notifier).clear();
    ref.read(selectedCombosProvider.notifier).clear();
    ref.read(bookingExpiryProvider.notifier).resetTimer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 20),
            const Text(
              'Successfully Ordered!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "You're all set for an amazing movie experience!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () {
                  _clearBookingFlow(ref);
                  context.go('/tickets');
                },
                child: const Text(
                  'View My Order',
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),
                onPressed: () {
                  _clearBookingFlow(ref);
                  context.go('/');
                },
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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

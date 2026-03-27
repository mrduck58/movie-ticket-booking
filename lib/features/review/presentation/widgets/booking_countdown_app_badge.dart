import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/booking_expiry_provider.dart';

class BookingCountdownAppbarBadge extends ConsumerWidget {
  const BookingCountdownAppbarBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expiry = ref.watch(bookingExpiryProvider);

    if (!expiry.isRunning || expiry.isExpired) {
      return const SizedBox.shrink();
    }

    final totalSeconds = expiry.remaining.inSeconds;
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.access_time,
            size: 16,
            color: Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            '$minutes:$seconds',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
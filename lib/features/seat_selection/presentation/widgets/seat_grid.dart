import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/seat.dart';
import '../providers/seat_providers.dart';
import 'seat_widget.dart';

class SeatGrid extends ConsumerWidget {
  final List<Seat> seats;

  const SeatGrid({super.key, required this.seats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSeats = ref.watch(selectedSeatsProvider);

    // sort ghế đúng thứ tự
    final sortedSeats = [...seats]
      ..sort((a, b) {
        final rowCompare = a.row.compareTo(b.row);
        if (rowCompare != 0) return rowCompare;
        return a.number.compareTo(b.number);
      });

    final leftSeats = sortedSeats.where((e) => e.number <= 5).toList();
    final rightSeats = sortedSeats.where((e) => e.number > 5).toList();

    return Row(
      children: [
        /// LEFT
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leftSeats.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              final seat = leftSeats[index];
              final selected = selectedSeats.any(
                (s) => s.seatId == seat.seatId,
              );

              return SeatWidget(
                seat: seat,
                selected: selected,
                onTap: () {
                  ref.read(selectedSeatsProvider.notifier).toggleSeat(seat);
                },
              );
            },
          ),
        ),

        const SizedBox(width: 30),

        /// RIGHT
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rightSeats.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              final seat = rightSeats[index];
              final selected = selectedSeats.any(
                (s) => s.seatId == seat.seatId,
              );

              return SeatWidget(
                seat: seat,
                selected: selected,
                onTap: () {
                  final notifier = ref.read(selectedSeatsProvider.notifier);
                  final current = [...selectedSeats];

                  if (selected) {
                    current.removeWhere((s) => s.seatId == seat.seatId);
                  } else {
                    current.add(seat);
                  }

                  notifier.state = current;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

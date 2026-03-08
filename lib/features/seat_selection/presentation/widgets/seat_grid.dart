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

    // chia ghế
    final leftSeats = seats.where((e) => e.number <= 5).toList();
    final rightSeats = seats.where((e) => e.number > 5).toList();

    return Row(
      children: [
        /// LEFT SIDE
        Expanded(
          child: GridView.builder(
            itemCount: leftSeats.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              final seat = leftSeats[index];
              final selected = selectedSeats.contains(seat);

              return SeatWidget(
                seat: seat,
                selected: selected,
                onTap: () {
                  final current = [...selectedSeats];

                  if (selected) {
                    current.remove(seat);
                  } else {
                    current.add(seat);
                  }

                  ref.read(selectedSeatsProvider.notifier).state = current;
                },
              );
            },
          ),
        ),

        /// AISLE (LỐI ĐI)
        const SizedBox(width: 30),

        /// RIGHT SIDE
        Expanded(
          child: GridView.builder(
            itemCount: rightSeats.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              final seat = rightSeats[index];
              final selected = selectedSeats.contains(seat);

              return SeatWidget(
                seat: seat,
                selected: selected,
                onTap: () {
                  final current = [...selectedSeats];

                  if (selected) {
                    current.remove(seat);
                  } else {
                    current.add(seat);
                  }

                  ref.read(selectedSeatsProvider.notifier).state = current;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
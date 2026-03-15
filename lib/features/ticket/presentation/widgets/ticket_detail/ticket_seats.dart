import 'package:flutter/material.dart';

class TicketSeats extends StatelessWidget {
  final List<String> seats;

  const TicketSeats({super.key, required this.seats});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: seats
          .map(
            (seat) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                seat,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
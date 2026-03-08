import 'package:flutter/material.dart';
import '../../../../domain/entities/seat.dart';

class SeatWidget extends StatelessWidget {

  final Seat seat;
  final bool selected;
  final VoidCallback onTap;

  const SeatWidget({
    super.key,
    required this.seat,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    Color color;

    if (seat.taken) {
      color = Colors.grey;
    } else if (selected) {
      color = Colors.red;
    } else {
      color = Colors.white;
    }

    return GestureDetector(
      onTap: seat.taken ? null : onTap,
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Text(
          "${seat.row}${seat.number}",
          style: TextStyle(
            fontSize: 11,
            color: seat.taken || selected
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
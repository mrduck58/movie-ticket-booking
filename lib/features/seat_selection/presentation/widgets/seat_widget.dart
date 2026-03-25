import 'package:flutter/material.dart';
import '../../../../domain/entities/seat.dart';
import '../../../../core/theme/app_colors.dart';

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

    if (seat.isBooked) {
      color = Colors.grey;
    } else if (seat.isLocked) {
      color = AppColors.seatSold;
    } else if (selected) {
      color = AppColors.primary;
    } else {
      color = Colors.white;
    }

    return GestureDetector(
      onTap: seat.isAvailable ? onTap : null,
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          seat.seatName,
          style: TextStyle(
            fontSize: 11,
            color: seat.isBooked || selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
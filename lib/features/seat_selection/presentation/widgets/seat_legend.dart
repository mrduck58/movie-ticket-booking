import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';

class SeatLegend extends StatelessWidget {
  const SeatLegend({super.key});

  Widget legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),

        const SizedBox(width: 5),

        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        legendItem(Colors.white, "Available"),

        const SizedBox(width: 30),

        legendItem(AppColors.seatSold, "Locked"),

        const SizedBox(width: 30),

        legendItem(Colors.grey, "Taken"),

        const SizedBox(width: 30),

        legendItem(AppColors.primary, "Selected"),
      ],
    );
  }
}

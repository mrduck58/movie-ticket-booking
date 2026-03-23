// import 'package:flutter/material.dart';
// import 'package:movie_ticket_booking/core/theme/app_colors.dart';
// import '../../data/models/seat_model.dart';

// class SeatItem extends StatelessWidget {
//   final SeatModel seat;
//   final bool selected;
//   final VoidCallback onTap;

//   const SeatItem({
//     super.key,
//     required this.seat,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color color;

//     if (seat.taken) {
//       color = Colors.grey;
//     } else if (selected) {
//       color = AppColors.primary;
//     } else {
//       color = Colors.white;
//     }

//     return GestureDetector(
//       onTap: seat.taken ? null : onTap,
//       child: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: color,
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Text(
//           "${seat.row}${seat.number}",
//           style: const TextStyle(fontSize: 10),
//         ),
//       ),
//     );
//   }
// }
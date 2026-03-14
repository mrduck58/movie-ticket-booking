import 'package:flutter/material.dart';

class TicketQR extends StatelessWidget {
  const TicketQR({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: 180,
          color: Colors.white,
          child: const Icon(Icons.qr_code, size: 150),
        ),

        const SizedBox(height: 10),

        const Text(
          "Scan this barcode at the entrance to the auditorium",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
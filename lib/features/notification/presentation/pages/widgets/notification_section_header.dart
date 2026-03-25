import 'package:flutter/material.dart';

/// =======================================================
/// HEADER CHO TỪNG SECTION NOTIFICATION
/// - Ví dụ:
///   Today --------
///   Earlier ------
///
/// Dùng line ngang bên phải để phân tách section rõ hơn.
/// =======================================================
class NotificationSectionHeader extends StatelessWidget {
  final String title;

  const NotificationSectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
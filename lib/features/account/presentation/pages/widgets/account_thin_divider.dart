import 'package:flutter/material.dart';

/// =======================================================
/// ĐƯỜNG DIVIDER MỎNG
/// - dùng để ngăn cách phần header với các menu
/// =======================================================
class AccountThinDivider extends StatelessWidget {
  const AccountThinDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.grey.shade300,
    );
  }
}
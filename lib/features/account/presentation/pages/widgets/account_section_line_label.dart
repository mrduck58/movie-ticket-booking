import 'package:flutter/material.dart';

/// =======================================================
/// LABEL CHO SECTION
/// - Ví dụ:
///   General
///   About
///
/// UI:
/// - có line ngang
/// - text nằm đè lên line ở bên trái
/// =======================================================
class AccountSectionLineLabel extends StatelessWidget {
  final String label;

  const AccountSectionLineLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        /// Line nền phía sau
        Container(height: 1, color: Colors.grey.shade300),

        /// Box trắng chứa label để che line phía sau
        Container(
          padding: const EdgeInsets.only(right: 10),
          color: Colors.white,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF9E9E9E),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
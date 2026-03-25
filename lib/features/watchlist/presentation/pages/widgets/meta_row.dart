import 'package:flutter/material.dart';

/// =======================================================
/// COMPONENT NHỎ: MetaLabelOnly
/// - Chỉ hiển thị label ở cột trái
/// - Ví dụ:
///   Duration
///   Director
///   AR
///   Genre
///
/// Dùng SizedBox width cố định để các dòng metadata thẳng hàng.
/// =======================================================
class MetaLabelOnly extends StatelessWidget {
  final String label;

  const MetaLabelOnly({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      /// Width cố định để label các dòng nằm cùng 1 cột.
      width: 66,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// =======================================================
/// COMPONENT NHỎ: MetaRow
/// - Render theo format:
///   [label] : [value]
///
/// Ví dụ:
///   Duration : 120 min
///   Director : Nolan
///
/// Tách riêng để tái sử dụng nhiều dòng metadata.
/// =======================================================
class MetaRow extends StatelessWidget {
  final String label;
  final String value;

  const MetaRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Cột label bên trái.
        MetaLabelOnly(label: label),

        /// Dấu ":" ở giữa.
        Text(
          ': ',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),

        /// Value bên phải.
        /// Dùng Expanded để tránh overflow khi text dài.
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
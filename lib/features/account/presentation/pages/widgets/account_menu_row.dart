import 'package:flutter/material.dart';

/// =======================================================
/// ITEM MENU TRONG ACCOUNT
/// - icon bên trái
/// - title
/// - trailing text hoặc trailing widget
/// - chevron bên phải (tuỳ chọn)
///
/// Dùng cho hầu hết menu trong màn Account.
/// =======================================================
class AccountMenuRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final Widget? trailingWidget;
  final bool showChevron;
  final Color titleColor;
  final Color iconColor;
  final VoidCallback? onTap;

  const AccountMenuRow({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.trailingWidget,
    this.showChevron = true,
    this.titleColor = Colors.black,
    this.iconColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            /// Icon bên trái
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 14),

            /// Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            ),

            /// Trailing widget custom, ví dụ Switch
            if (trailingWidget != null) trailingWidget!,

            /// Trailing text, ví dụ Language
            if (trailingText != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  trailingText!,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFFB0B0B0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            /// Chevron phải
            if (showChevron)
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFB0B0B0),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
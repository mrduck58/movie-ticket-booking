import 'package:flutter/material.dart';

import '../../../domain/entities/user_profile.dart';
import '../utils/account_formatters.dart';

/// =======================================================
/// HEADER THÔNG TIN USER
/// - avatar
/// - tên
/// - email hoặc userId
/// - icon QR ở bên phải
///
/// Nếu user không có avatar:
/// - hiển thị chữ cái đầu tên
/// =======================================================
class AccountHeader extends StatelessWidget {
  final UserProfile user;

  const AccountHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// =========================
        /// AVATAR
        /// - nếu có avatar URL -> dùng NetworkImage
        /// - nếu không -> hiện chữ cái đầu
        /// =========================
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFFD9D9D9),
          backgroundImage:
              user.avatar.trim().isNotEmpty ? NetworkImage(user.avatar) : null,
          child: user.avatar.trim().isEmpty
              ? Text(
                  buildAccountInitial(user.name),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                )
              : null,
        ),

        const SizedBox(width: 12),

        /// =========================
        /// TÊN + EMAIL/USERID
        /// =========================
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                user.email.isNotEmpty ? user.email : user.userId,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        /// Icon QR
        const Icon(Icons.qr_code_2, size: 18),
      ],
    );
  }
}
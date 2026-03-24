import 'package:flutter/material.dart';

/// =======================================================
/// DIALOG XÁC NHẬN LOGOUT
/// - Trả về:
///   + true  -> user xác nhận đăng xuất
///   + false -> user huỷ
///   + null  -> dialog bị dismiss ngoài ý muốn
/// =======================================================
Future<bool?> showLogoutConfirmDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm'),
      content: const Text('Bạn có muốn đăng xuất không?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Đăng xuất'),
        ),
      ],
    ),
  );
}
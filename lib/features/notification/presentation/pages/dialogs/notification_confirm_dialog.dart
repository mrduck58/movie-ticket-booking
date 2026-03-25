import 'package:flutter/material.dart';

/// =======================================================
/// DIALOG XÁC NHẬN DÙNG CHO NOTIFICATION
/// - dùng cho:
///   + delete 1 notification
///   + clear all notifications
///
/// Trả về:
/// - true  -> xác nhận
/// - false -> hủy
/// - null  -> dismiss ngoài ý muốn
/// =======================================================
Future<bool?> showNotificationConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String confirmText,
  bool isDanger = false,
}) {
  final actionColor = isDanger ? Colors.red : Colors.black;

  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: actionColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}
import 'package:flutter/material.dart';

/// Import màu dùng chung từ core.
/// Ở đây dùng AppColors.error để giữ đúng màu đỏ của nút Remove,
/// tránh hard-code màu trực tiếp trong file.
import '../../../../../core/theme/app_colors.dart';

/// Import radius dùng chung từ core.
/// Dùng AppRadius.md cho bo góc button để đồng bộ với design system.
import '../../../../../core/theme/app_radius.dart';

/// =======================================================
/// DIALOG XÁC NHẬN XÓA KHỎI WATCHLIST
/// - Đây là 1 hàm helper trả về Future<bool?>
/// - Kết quả:
///   + true  -> user xác nhận remove
///   + false -> user bấm cancel
///   + null  -> dialog bị dismiss ngoài ý muốn (tap ra ngoài)
///
/// Tách dialog ra file riêng giúp:
/// - màn hình chính gọn hơn
/// - dễ tái sử dụng
/// - dễ chỉnh UI dialog mà không ảnh hưởng code screen
/// =======================================================
Future<bool?> showRemoveConfirmDialog(
  BuildContext context, {
  required String movieTitle,
}) {
  return showDialog<bool>(
    context: context,

    /// Cho phép chạm ra ngoài để đóng dialog.
    /// Khi đó kết quả có thể là null.
    barrierDismissible: true,

    builder: (context) {
      return AlertDialog(
        /// Bo góc cho toàn bộ khung dialog.
        /// Ở đây đang giữ 18 để khớp UI cũ.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        /// =========================
        /// TITLE
        /// =========================
        title: const Text(
          'Remove from watchlist?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),

        /// =========================
        /// CONTENT
        /// - Chèn tên phim vào câu xác nhận
        /// =========================
        content: Text(
          'Do you want to remove "$movieTitle" from your watchlist?',
          style: const TextStyle(
            fontSize: 14,
            height: 1.45,
            color: Colors.black87,
          ),
        ),

        /// Padding cho khu vực actions phía dưới.
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),

        actions: [
          /// =========================
          /// NÚT CANCEL
          /// - Trả về false
          /// - Dùng OutlinedButton để phân biệt với action chính
          /// =========================
          SizedBox(
            height: 40,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context, false),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          /// =========================
          /// NÚT REMOVE
          /// - Trả về true
          /// - Dùng màu đỏ để thể hiện destructive action
          /// =========================
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              child: const Text(
                'Remove',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
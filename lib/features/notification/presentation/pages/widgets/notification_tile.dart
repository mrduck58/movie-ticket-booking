import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/notification_item.dart';
import '../utils/notification_mapper.dart';
import 'notification_leading_widget.dart';

/// =======================================================
/// ITEM THÔNG BÁO
/// - hiển thị:
///   + icon tròn bên trái
///   + title theo type
///   + badge "New" nếu unread
///   + message
///   + time
///   + nút delete
/// =======================================================
class NotificationTile extends StatelessWidget {
  final AppNotification data;
  final Color unreadColor;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationTile({
    super.key,
    required this.data,
    required this.unreadColor,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    /// Format giờ kiểu 08:30 AM
    final timeText = DateFormat('hh:mm a').format(data.time);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Icon tròn bên trái
            NotificationLeadingWidget(data: data),
            const SizedBox(width: 12),

            /// Phần text bên phải
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// =========================
                  /// HÀNG TITLE + BADGE NEW
                  /// =========================
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notificationTitleByType(data),
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight:
                                data.isUnread ? FontWeight.w800 : FontWeight.w700,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ),

                      /// Chỉ hiện badge nếu unread
                      if (data.isUnread)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: unreadColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'New',
                            style: TextStyle(
                              color: unreadColor,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// Nội dung thông báo
                  Text(
                    data.message,
                    style: TextStyle(
                      fontSize: 11.5,
                      color:
                          data.isUnread ? Colors.grey.shade800 : Colors.grey.shade600,
                      height: 1.3,
                      fontWeight:
                          data.isUnread ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// =========================
                  /// HÀNG GIỜ + DELETE
                  /// =========================
                  Row(
                    children: [
                      Text(
                        timeText,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: onDelete,
                        visualDensity: VisualDensity.compact,
                        splashRadius: 18,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
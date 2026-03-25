import 'package:flutter/material.dart';

import '../../../domain/entities/notification_item.dart';
import '../utils/notification_mapper.dart';

/// =======================================================
/// ICON TRÒN BÊN TRÁI CỦA THÔNG BÁO
/// - icon thay đổi theo type notification
/// =======================================================
class NotificationLeadingWidget extends StatelessWidget {
  final AppNotification data;

  const NotificationLeadingWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12, width: 1),
        color: Colors.white,
      ),
      child: Icon(
        notificationIconByType(data.type),
        size: 22,
        color: Colors.black,
      ),
    );
  }
}
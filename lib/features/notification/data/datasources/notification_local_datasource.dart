import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/notification_model.dart';

class NotificationLocalDataSource {
  Future<List<AppNotificationModel>> getNotifications() async {
    final raw = await rootBundle.loadString(
      'assets/mock/notifications.json',
    );

    final map = json.decode(raw);
    final list = map['notifications'] as List;

    return list
        .map((e) => AppNotificationModel.fromJson(e))
        .toList();
  }
}
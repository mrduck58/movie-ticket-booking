import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/notification_item.dart';
import '../../domain/repositories/notification_repository.dart';
import 'notification_providers.dart';
import 'notification_state.dart';

class NotificationController
    extends AsyncNotifier<List<NotificationSection>> {

  late final NotificationRepository _repo;

  @override
  Future<List<NotificationSection>> build() async {
    _repo = ref.read(notificationRepositoryProvider);

    final list = await _repo.getNotifications();

    list.sort((a, b) => b.time.compareTo(a.time));

    return _group(list);
  }

  List<NotificationSection> _group(List<AppNotification> list) {
    final now = DateTime.now();

    String sectionTitle(DateTime t) {
      final diff = now.difference(t).inDays;

      if (diff == 0) return "Today";
      if (diff == 1) return "Yesterday";

      return DateFormat('MMM dd, yyyy').format(t);
    }

    final Map<String, List<AppNotification>> map = {};

    for (final n in list) {
      final key = sectionTitle(n.time);

      map.putIfAbsent(key, () => []);
      map[key]!.add(n);
    }

    return map.entries
        .map((e) => NotificationSection(
              title: e.key,
              items: e.value,
            ))
        .toList();
  }
}
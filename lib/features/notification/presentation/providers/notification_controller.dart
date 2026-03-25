import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/notification_item.dart';
import '../../domain/repositories/notification_repository.dart';
import 'notification_providers.dart';
import 'notification_state.dart';

class NotificationController extends AsyncNotifier<List<NotificationSection>> {
  late final NotificationRepository _repo;

  @override
  Future<List<NotificationSection>> build() async {
    _repo = ref.read(notificationRepositoryProvider);
    final list = await _repo.getNotifications();
    return _group(list);
  }

  Future<void> refreshData() async {
    state = const AsyncLoading();
    final list = await _repo.getNotifications();
    state = AsyncData(_group(list));
  }

  Future<void> markAsRead(String notificationId) async {
    final current = state.value;
    if (current == null) return;

    _updateLocalRead(notificationId);

    try {
      await _repo.markAsRead(notificationId);
    } catch (_) {
      state = AsyncData(current);
      rethrow;
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    final current = state.value;
    if (current == null) return;

    _removeLocal(notificationId);

    try {
      await _repo.deleteNotification(notificationId);
    } catch (_) {
      state = AsyncData(current);
      rethrow;
    }
  }

  Future<void> clearAll() async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncData([]);

    try {
      await _repo.clearAll();
    } catch (_) {
      state = AsyncData(current);
      rethrow;
    }
  }

  void _updateLocalRead(String notificationId) {
    final sections = state.value ?? [];

    final updated = sections
        .map(
          (section) => NotificationSection(
            title: section.title,
            items: section.items
                .map(
                  (item) => item.id == notificationId
                      ? item.copyWith(isUnread: false)
                      : item,
                )
                .toList(),
          ),
        )
        .toList();

    state = AsyncData(updated);
  }

  void _removeLocal(String notificationId) {
    final sections = state.value ?? [];

    final updated = sections
        .map(
          (section) => NotificationSection(
            title: section.title,
            items: section.items
                .where((item) => item.id != notificationId)
                .toList(),
          ),
        )
        .where((section) => section.items.isNotEmpty)
        .toList();

    state = AsyncData(updated);
  }

  List<NotificationSection> _group(List<AppNotification> list) {
    final sorted = [...list]..sort((a, b) => b.time.compareTo(a.time));
    final now = DateTime.now();

    String sectionTitle(DateTime t) {
      final diff = DateTime(now.year, now.month, now.day)
          .difference(DateTime(t.year, t.month, t.day))
          .inDays;

      if (diff == 0) return 'Today';
      if (diff == 1) return 'Yesterday';
      return DateFormat('MMM dd, yyyy').format(t);
    }

    final map = <String, List<AppNotification>>{};

    for (final n in sorted) {
      final key = sectionTitle(n.time);
      map.putIfAbsent(key, () => []);
      map[key]!.add(n);
    }

    return map.entries
        .map((e) => NotificationSection(title: e.key, items: e.value))
        .toList();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:movie_ticket_booking/features/notification/presentation/providers/notification_providers.dart';
import 'package:movie_ticket_booking/features/notification/domain/entities/notification_item.dart';
import 'package:movie_ticket_booking/features/notification/presentation/pages/dialogs/notification_confirm_dialog.dart';
import 'package:movie_ticket_booking/features/notification/presentation/pages/widgets/notification_section_header.dart';
import 'package:movie_ticket_booking/features/notification/presentation/pages/widgets/notification_tile.dart';

/// =======================================================
/// MÀN HÌNH NOTIFICATION
/// - Hiển thị danh sách thông báo theo từng section
///   ví dụ: Today / Earlier / ...
/// =======================================================
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const red = Color(0xFFE53935);
    final vm = ref.watch(notificationControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) async {
              if (value == 'settings') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings not available')),
                );
              }
              if (value == 'clear_all') {
                final confirm = await showNotificationConfirmDialog(
                  context,
                  title: 'Delete all?',
                  content: 'All notifications will be removed.',
                  confirmText: 'Clear all',
                  isDanger: true,
                );
                if (confirm == true) {
                  try {
                    await ref.read(notificationControllerProvider.notifier).clearAll();
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'settings', child: Text('Notification settings')),
              const PopupMenuItem(
                value: 'clear_all',
                child: Text('Clear all', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: vm.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (sections) {
          final hasItems = sections.any((e) => e.items.isNotEmpty);
          if (!hasItems) {
            return const Center(child: Text('No notifications'));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            itemCount: sections.length,
            itemBuilder: (context, sectionIndex) {
              final section = sections[sectionIndex];
              if (section.items.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NotificationSectionHeader(title: section.title),
                  const SizedBox(height: 10),
                  ...section.items.map((n) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: NotificationTile(
                        data: n,
                        unreadColor: red,
                        onTap: () async {
                          if (n.isUnread) {
                            try {
                              await ref.read(notificationControllerProvider.notifier).markAsRead(n.id);
                            } catch (e) {
                              // Ignore
                            }
                          }

                          if (n.type == NotificationType.bookingSuccess && n.relatedId != null) {
                            if (context.mounted) {
                              context.push('/booking-detail/${n.relatedId}');
                            }
                          }
                        },
                        onDelete: () async {
                          final confirm = await showNotificationConfirmDialog(
                            context,
                            title: 'Delete notification?',
                            content: 'This notification will be removed.',
                            confirmText: 'Delete',
                            isDanger: true,
                          );
                          if (confirm == true) {
                            try {
                              await ref.read(notificationControllerProvider.notifier).deleteNotification(n.id);
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              }
                            }
                          }
                        },
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/notification_providers.dart';
import '../dialogs/notification_confirm_dialog.dart';
import '../widgets/notification_section_header.dart';
import '../widgets/notification_tile.dart';

/// =======================================================
/// MÀN HÌNH NOTIFICATION
/// - Hiển thị danh sách thông báo theo từng section
///   ví dụ: Today / Earlier / ...
/// - Có popup menu:
///   + Notification settings
///   + Clear all
///
/// Dùng ConsumerWidget vì:
/// - chỉ cần đọc state từ Riverpod
/// - không cần giữ state nội bộ như TabController hay TextController
/// =======================================================
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Màu đỏ dùng cho badge unread / hành động nguy hiểm
    const red = Color(0xFFE53935);

    /// Lắng nghe state từ Riverpod
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

        /// =========================
        /// POPUP MENU BÊN PHẢI APPBAR
        /// - settings
        /// - clear all
        /// =========================
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) async {
              /// Notification settings: hiện chỉ demo snackbar
              if (value == 'settings') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notification settings is not available yet'),
                  ),
                );
              }

              /// Clear all notifications
              if (value == 'clear_all') {
                /// Kiểm tra xem có item nào để xóa không
                final hasItems = vm.maybeWhen(
                  data: (sections) => sections.any((e) => e.items.isNotEmpty),
                  orElse: () => false,
                );

                if (!hasItems) return;

                /// Hỏi xác nhận trước khi xóa tất cả
                final confirm = await showNotificationConfirmDialog(
                  context,
                  title: 'Delete all notifications?',
                  content: 'All notifications will be removed.',
                  confirmText: 'Clear all',
                  isDanger: true,
                );

                if (confirm == true) {
                  try {
                    await ref
                        .read(notificationControllerProvider.notifier)
                        .clearAll();

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All notifications deleted'),
                        ),
                      );
                    }
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
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'settings',
                child: Text(
                  'Notification settings',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'clear_all',
                child: Text(
                  'Clear all',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 6),
        ],
      ),

      /// =========================
      /// BODY
      /// - loading
      /// - error
      /// - data
      /// =========================
      body: vm.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              e.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (sections) {
          /// Kiểm tra có thông báo hay không
          final hasItems = sections.any((e) => e.items.isNotEmpty);

          if (!hasItems) {
            return const Center(
              child: Text(
                'No notifications',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          return SafeArea(
            top: false,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              itemCount: sections.length,
              itemBuilder: (context, sectionIndex) {
                final section = sections[sectionIndex];

                /// Nếu section rỗng thì bỏ qua
                if (section.items.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header section
                    NotificationSectionHeader(title: section.title),
                    const SizedBox(height: 10),

                    /// Danh sách notification trong section
                    ...List.generate(section.items.length, (i) {
                      final n = section.items[i];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: NotificationTile(
                          data: n,
                          unreadColor: red,

                          /// Khi tap vào item:
                          /// - nếu unread thì mark as read
                          onTap: () async {
                            if (n.isUnread) {
                              try {
                                await ref
                                    .read(notificationControllerProvider.notifier)
                                    .markAsRead(n.id);
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              }
                            }
                          },

                          /// Xóa từng notification
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
                                await ref
                                    .read(notificationControllerProvider.notifier)
                                    .deleteNotification(n.id);

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Notification deleted'),
                                    ),
                                  );
                                }
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
                    }),

                    const SizedBox(height: 8),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
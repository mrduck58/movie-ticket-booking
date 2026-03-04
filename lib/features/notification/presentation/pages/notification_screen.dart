import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/notification_providers.dart';
// import '../providers/notification_state.dart';
import '../../domain/entities/notification_item.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const red = Color(0xFFE53935);

    final vm = ref.watch(notificationControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
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
          "Notification",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
          ),
          const SizedBox(width: 6),
        ],
      ),

      /// BODY
      body: vm.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (sections) {
          return SafeArea(
            top: false,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              itemCount: sections.length,
              itemBuilder: (context, sectionIndex) {
                final section = sections[sectionIndex];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(title: section.title),

                    const SizedBox(height: 10),

                    ...List.generate(section.items.length, (i) {
                      final n = section.items[i];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _NotificationTile(
                          data: n,
                          unreadDotColor: red,
                          onTap: () {},
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

/// SECTION HEADER
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}

/// TILE
class _NotificationTile extends StatelessWidget {
  final AppNotification data;
  final Color unreadDotColor;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.data,
    required this.unreadDotColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final timeText = DateFormat('hh:mm a').format(data.time);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LeadingWidget(data: data),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),

                if (data.subtitle != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    data.subtitle!,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade600,
                      height: 1.25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],

                const SizedBox(height: 8),

                Text(
                  timeText,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: data.isUnread
                ? Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: unreadDotColor,
                      shape: BoxShape.circle,
                    ),
                  )
                : const SizedBox(width: 6, height: 6),
          ),

          if (data.showChevron) ...[
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
                size: 22,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// LEADING
class _LeadingWidget extends StatelessWidget {
  final AppNotification data;

  const _LeadingWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    switch (data.leadingType) {
      case LeadingType.circleIcon:
        return Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black12, width: 1),
            color: Colors.white,
          ),
          child: Icon(
            _mapIcon(data.icon),
            size: 22,
            color: Colors.black,
          ),
        );

      case LeadingType.poster:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 44,
            height: 44,
            child: Image.network(
              data.posterUrl ?? "",
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child:
                    const Icon(Icons.image_not_supported_outlined, size: 18),
              ),
            ),
          ),
        );
    }
  }

  IconData _mapIcon(String? iconName) {
    switch (iconName) {
      case "check_rounded":
        return Icons.check_rounded;
      case "shield_outlined":
        return Icons.shield_outlined;
      case "credit_card_outlined":
        return Icons.credit_card_outlined;
      case "local_activity_outlined":
        return Icons.local_activity_outlined;
      default:
        return Icons.notifications_none;
    }
  }
}
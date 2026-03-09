import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/account_providers.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const red = Color(0xFFE53935);

    final vm = ref.watch(accountControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),

      /// BODY
      body: vm.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (state) {
          final user = state.user;

          return SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 90),
              children: [
                /// USER HEADER
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFFD9D9D9),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            user.email,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.qr_code_2, size: 18),
                  ],
                ),

                const SizedBox(height: 12),
                const _ThinDivider(),
                const SizedBox(height: 6),

                /// WATCHLIST
                _MenuRow(
                  icon: Icons.favorite_border,
                  title: "Watchlist",
                  onTap: () {
                    context.push('/watchlist');
                  },
                ),

                const _MenuRow(
                  icon: Icons.grid_view_outlined,
                  title: "Movie Interest",
                ),

                _MenuRow(
                  icon: Icons.credit_card_outlined,
                  title: "Payment Methods",
                  onTap: () {
                    context.push('/payment-methods');
                  },
                ),

                const SizedBox(height: 14),
                const _SectionLineLabel(label: "General"),
                const SizedBox(height: 8),

                const _MenuRow(
                  icon: Icons.person_outline,
                  title: "Personal Info",
                ),

                _MenuRow(
                  icon: Icons.notifications_none,
                  title: "Notification",
                  onTap: () {
                    context.push('/notifications');
                  },
                ),

                const _MenuRow(icon: Icons.shield_outlined, title: "Security"),

                const _MenuRow(
                  icon: Icons.translate,
                  title: "Language",
                  trailingText: "English (US)",
                ),

                _MenuRow(
                  icon: Icons.dark_mode_outlined,
                  title: "Darkmode",
                  trailingWidget: Transform.scale(
                    scale: 0.9,
                    child: Switch(
                      value: false,
                      onChanged: (_) {},
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),

                const SizedBox(height: 14),
                const _SectionLineLabel(label: "About"),
                const SizedBox(height: 8),

                const _MenuRow(icon: Icons.help_outline, title: "Help Center"),

                const _MenuRow(
                  icon: Icons.info_outline,
                  title: "About VNAPH Booking",
                ),

                const _MenuRow(
                  icon: Icons.logout,
                  title: "Logout",
                  iconColor: red,
                  titleColor: red,
                  showChevron: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// DIVIDER
class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: Colors.grey.shade300);
  }
}

/// SECTION LABEL
class _SectionLineLabel extends StatelessWidget {
  final String label;

  const _SectionLineLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(height: 1, color: Colors.grey.shade300),
        Container(
          padding: const EdgeInsets.only(right: 10),
          color: Colors.white,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF9E9E9E),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

/// MENU ROW
class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final Widget? trailingWidget;
  final bool showChevron;
  final Color titleColor;
  final Color iconColor;
  final VoidCallback? onTap;

  const _MenuRow({
    required this.icon,
    required this.title,
    this.trailingText,
    this.trailingWidget,
    this.showChevron = true,
    this.titleColor = Colors.black,
    this.iconColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            ),
            if (trailingWidget != null) trailingWidget!,
            if (trailingText != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  trailingText!,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFFB0B0B0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (showChevron)
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFB0B0B0),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}

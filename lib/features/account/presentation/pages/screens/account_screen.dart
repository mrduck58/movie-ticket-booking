import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/login/presentation/provider/login_provider.dart';

import '../../providers/account_providers.dart';
import '../dialogs/logout_confirm_dialog.dart';
import '../widgets/account_header.dart';
import '../widgets/account_menu_row.dart';
import '../widgets/account_section_line_label.dart';
import '../widgets/account_thin_divider.dart';

/// =======================================================
/// MÀN HÌNH ACCOUNT
/// - Hiển thị thông tin user
/// - Hiển thị các menu điều hướng:
///   + Watchlist
///   + Payment Methods
///   + Personal Info
///   + Notification
///   + ...
/// - Hỗ trợ logout
///
/// Dùng ConsumerWidget vì:
/// - chỉ cần đọc state từ Riverpod
/// - không có state nội bộ cần quản lý
/// =======================================================
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const red = Color(0xFFE53935);

    /// Lắng nghe state account từ Riverpod
    final vm = ref.watch(accountControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Account',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: vm.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(e.toString(), textAlign: TextAlign.center),
          ),
        ),
        data: (state) {
          final user = state.user;

          return SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 90),
              children: [
                /// =========================
                /// THÔNG TIN USER Ở ĐẦU TRANG
                /// - avatar
                /// - tên
                /// - email / userId
                /// - icon QR
                /// =========================
                AccountHeader(user: user),

                const SizedBox(height: 12),
                const AccountThinDivider(),
                const SizedBox(height: 6),

                /// =========================
                /// NHÓM MENU ĐẦU
                /// =========================
                AccountMenuRow(
                  icon: Icons.favorite_border,
                  title: 'Watchlist',
                  onTap: () {
                    context.push('/watchlist');
                  },
                ),

                const AccountMenuRow(
                  icon: Icons.grid_view_outlined,
                  title: 'Movie Interest',
                ),

                AccountMenuRow(
                  icon: Icons.credit_card_outlined,
                  title: 'Payment Methods',
                  onTap: () {
                    context.push('/payment-methods');
                  },
                ),

                const SizedBox(height: 14),
                const AccountSectionLineLabel(label: 'General'),
                const SizedBox(height: 8),

                /// =========================
                /// NHÓM GENERAL
                /// =========================
                AccountMenuRow(
                  icon: Icons.person_outline,
                  title: 'Personal Info',
                  onTap: () {
                    context.push('/profile');
                  },
                ),

                AccountMenuRow(
                  icon: Icons.notifications_none,
                  title: 'Notification',
                  onTap: () {
                    context.push('/notifications');
                  },
                ),

                AccountMenuRow(
                  icon: Icons.article_outlined,
                  title: 'Post',
                  onTap: () {
                    context.push('/blog-posts');
                  },
                ),

                const AccountMenuRow(
                  icon: Icons.translate,
                  title: 'Language',
                  trailingText: 'English (US)',
                ),

                // AccountMenuRow(
                //   icon: Icons.dark_mode_outlined,
                //   title: 'Darkmode',
                //   trailingWidget: Transform.scale(
                //     scale: 0.9,
                //     child: Switch(
                //       value: false,
                //       onChanged: (_) {},
                //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //     ),
                //   ),
                // ),

                const SizedBox(height: 14),
                const AccountSectionLineLabel(label: 'About'),
                const SizedBox(height: 8),

                /// =========================
                /// NHÓM ABOUT
                /// =========================
                AccountMenuRow(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () {
                    context.push('/help-center');
                  },
                ),

                AccountMenuRow(
                  icon: Icons.info_outline,
                  title: 'About VNAPH Booking',
                  onTap: () {
                    context.push('/about-app');
                  },
                ),

                /// =========================
                /// LOGOUT
                /// =========================
                AccountMenuRow(
                  icon: Icons.logout,
                  title: 'Logout',
                  iconColor: red,
                  titleColor: red,
                  showChevron: false,
                  onTap: () async {
                    final confirm = await showLogoutConfirmDialog(context);

                    if (confirm == true) {
                      await ref.read(loginProvider).logout();
                      ref.invalidate(accountControllerProvider);
                      if (context.mounted) {
                        context.go('/login');
                      }
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

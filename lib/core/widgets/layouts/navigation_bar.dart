import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Thêm cái này
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/login/presentation/provider/login_provider.dart'; // Đảm bảo đúng đường dẫn

class MainLayout extends ConsumerWidget { // Chuyển sang ConsumerWidget
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Thêm WidgetRef ref
    const red = Color(0xFFE53935);
    
    // 1. Kiểm tra trạng thái đăng nhập ở đây
    final authState = ref.watch(loginProvider);
    final bool isLoggedIn = authState.token != null && 
                            authState.token != 'null' && 
                            authState.token!.isNotEmpty;

    int currentIndex = _locationToIndex(
      GoRouterState.of(context).uri.toString(),
    );

    return Scaffold(
      body: child,
      // 🔥 CHỐT CHẶN: Nếu chưa đăng nhập (isLoggedIn == false) thì trả về null để ẩn thanh
      bottomNavigationBar: isLoggedIn 
          ? BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: red,
              onTap: (index) {
                switch (index) {
                  case 0: context.go('/'); break;
                  case 1: context.go('/cinemas'); break;
                  case 2: context.go('/tickets'); break;
                  case 3: context.go('/search'); break;
                  case 4: context.go('/account'); break;
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), activeIcon: Icon(Icons.grid_view), label: "Cinemas"),
                BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), activeIcon: Icon(Icons.confirmation_number), label: "My Tickets"),
                BottomNavigationBarItem(icon: Icon(Icons.search_outlined), activeIcon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: "Account"),
              ],
            )
          : null, // 🛡️ ẨN HOÀN TOÀN KHI CHƯA LOGIN
    );
  }

  int _locationToIndex(String location) {
    if (location.startsWith('/cinemas')) return 1;
    if (location.startsWith('/tickets')) return 2;
    if (location.startsWith('/search')) return 3;
    if (location.startsWith('/account')) return 4;
    return 0;
  }
}
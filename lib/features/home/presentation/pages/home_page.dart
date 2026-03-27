import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// --- Imports (Giữ nguyên các đường dẫn của ông) ---
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft.dart';
import 'package:movie_ticket_booking/features/home/presentation/providers/home_providers.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft_provider.dart';
import 'package:movie_ticket_booking/features/login/presentation/provider/login_provider.dart' hide currentUserProvider;
import '../../data/models/user_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int bannerIndex = 0;

  @override
  void initState() {
    super.initState();
    // Luôn cập nhật trạng thái login khi vào app
    Future.microtask(() => ref.read(loginProvider.notifier).checkLoginStatus());
  }

  // 🔥 1. HÀM HIỆN POPUP CHỌN YES/NO THEO Ý ÔNG
  void _showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Please sign in"),
        content: const Text("You need to log in to book tickets. Would you like to go to the login page now?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Later", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/intro');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4D67),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Sign in"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieAsync = ref.watch(movieProvider);
    final authState = ref.watch(loginProvider);
    
    // Logic kiểm tra login chuẩn (loại bỏ chuỗi 'null' rác)
    final bool isLoggedIn = authState.token != null && 
                            authState.token != 'null' && 
                            authState.token!.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: movieAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Error: $e")),
          data: (movies) {
            final banners = movies.take(10).toList();
            final nowPlaying = movies.where((m) => m.status == "NOWSHOWING").toList();
            final comingSoon = movies.where((m) => m.status == "COMINGSOON").toList();

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 10),

                // 🔥 2. THANH LOCATION BAR (GIỮ NGUYÊN RUỘT CỦA ÔNG - CHỈ HIỆN KHI LOGIN)
                if (isLoggedIn) ...[
                  const _TopLocationBar(),
                  const SizedBox(height: 16),
                ],

                _BannerCarousel(
                  items: banners.map((e) => e.posterUrl ?? "https://via.placeholder.com/300x200").toList(),
                  onIndexChanged: (i) => setState(() => bannerIndex = i),
                ),

                const SizedBox(height: 8),
                _DotsIndicator(count: banners.length, index: bannerIndex),
                const SizedBox(height: 20),

                _SectionHeader(
                  title: "Now Playing",
                  onViewAll: () => context.push('/now-playing'),
                ),
                const SizedBox(height: 10),

                SizedBox(
                  height: 270,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: nowPlaying.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final m = nowPlaying[index];
                      return _MovieCard(
                        title: m.title,
                        imageUrl: m.posterUrl ?? "https://via.placeholder.com/300",
                        onTap: () {
                          ref.read(bookingDraftProvider.notifier).state = BookingDraft(movie: m.toEntity());
                          context.push('/movies/${m.movieId}');
                        },
                        onBookNow: () {
                          // 🔥 3. LOGIC POPUP TẠI ĐÂY
                          if (isLoggedIn) {
                            ref.read(bookingDraftProvider.notifier).state = BookingDraft(movie: m.toEntity());
                            context.push('/movies/${m.movieId}/cinemas');
                          } else {
                            _showLoginRequiredDialog(context);
                          }
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                _SectionHeader(title: "Coming Soon", onViewAll: () => context.push('/coming-soon')),
                const SizedBox(height: 10),

                SizedBox(
                  height: 270,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: comingSoon.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final m = comingSoon[index];
                      return _MovieCard(
                        title: m.title,
                        imageUrl: m.posterUrl ?? "https://via.placeholder.com/300",
                        onTap: () {
                          ref.read(bookingDraftProvider.notifier).state = BookingDraft(movie: m.toEntity());
                          context.push('/movies/${m.movieId}');
                        },
                        onBookNow: () {
                          // 🔥 3. LOGIC POPUP TẠI ĐÂY
                          if (isLoggedIn) {
                            ref.read(bookingDraftProvider.notifier).state = BookingDraft(movie: m.toEntity());
                            context.push('/movies/${m.movieId}');
                          } else {
                            _showLoginRequiredDialog(context);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}

// --- WIDGET THANH LOCATION BAR (GIỮ NGUYÊN LOGIC BAN ĐẦU CỦA ÔNG) ---
class _TopLocationBar extends ConsumerWidget {
  const _TopLocationBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const accent = Color(0xFFFF4D67);
    final userAsync = ref.watch(currentUserProvider);

    return Row(
      children: [
        userAsync.when(
          data: (user) => Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: user.avatarUrl.isNotEmpty ? NetworkImage(user.avatarUrl) : null,
                child: user.avatarUrl.isEmpty ? const Icon(Icons.person) : null,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                  Text(
                    user.name, // ĐÂY LÀ CHỖ HIỆN "Nguyen Vuong"
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          loading: () => const SizedBox(
            width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (e, _) => const Text("Error"),
        ),
        const Spacer(),
        // 🔔 Notification
        Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: () => context.push("/notifications"),
              child: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black12)),
                child: const Icon(Icons.notifications_none),
              ),
            ),
            Positioned(
              right: 10, top: 10,
              child: Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: accent)),
            ),
          ],
        ),
      ],
    );
  }
}

// --- CÁC WIDGET PHỤ TRỢ (BANNER, CARDS, DOTS...) GIỮ NGUYÊN TỪ CODE CỦA ÔNG ---

class _BannerCarousel extends StatelessWidget {
  final List<String> items;
  final ValueChanged<int> onIndexChanged;
  const _BannerCarousel({required this.items, required this.onIndexChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: PageView.builder(
          itemCount: items.length,
          onPageChanged: onIndexChanged,
          itemBuilder: (context, index) => Image.network(
            items[index], fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey[300], child: const Icon(Icons.image_not_supported)),
          ),
        ),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int index;
  const _DotsIndicator({required this.count, required this.index});
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(count, (i) => 
    AnimatedContainer(duration: const Duration(milliseconds: 200), margin: const EdgeInsets.symmetric(horizontal: 4), width: i == index ? 10 : 7, height: 7, decoration: BoxDecoration(color: i == index ? const Color(0xFFFF4D67) : Colors.black26, borderRadius: BorderRadius.circular(100)))));
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  const _SectionHeader({required this.title, required this.onViewAll});
  @override
  Widget build(BuildContext context) => Row(children: [
    Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
    const Spacer(),
    InkWell(onTap: onViewAll, child: const Text("View all >", style: TextStyle(color: Color(0xFFFF4D67), fontWeight: FontWeight.w600))),
  ]);
}

class _MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback onBookNow;
  const _MovieCard({required this.title, required this.imageUrl, required this.onTap, required this.onBookNow});
  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFFF4D67);
    return InkWell(
      onTap: onTap,
      child: SizedBox(width: 150, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(16), child: AspectRatio(aspectRatio: 3 / 4, child: Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[300], child: const Icon(Icons.broken_image))))),
        const SizedBox(height: 8),
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(height: 34, child: OutlinedButton(onPressed: onBookNow, style: OutlinedButton.styleFrom(foregroundColor: accent, side: const BorderSide(color: accent), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text("Book Now"))),
      ])),
    );
  }
}
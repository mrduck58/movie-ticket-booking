import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/home/presentation/providers/home_providers.dart';

import '../../../checkout/providers/booking_draft_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _bannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final movieAsync = ref.watch(movieProvider);

    // TODO: implement build
    return Scaffold(
      //appBar: AppBar(title: Text("Home")),
      body: SafeArea(
        child: movieAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (movies) {
            final banners = movies.take(5).toList();
             return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                const _TopLocationBar(),
                const SizedBox(height: 14),

                _BannerCarousel(
                  items: banners.map((m) => m.posterUrl).toList(),
                  onIndexChanged: (i) => setState(() => _bannerIndex = i),
                ),
                const SizedBox(height: 8),
                _DotsIndicator(count: banners.length, index: _bannerIndex),

                const SizedBox(height: 18),
                _SectionHeader(
                  title: 'Now Playing',
                  onViewAll: () {
                    // sau này: context.go('/movies/now-playing');
                  },
                ),
                const SizedBox(height: 10),

                SizedBox(
                  height: 240,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final m = movies[index];
                      return _MovieCard(
                        title: m.title,
                        imageUrl: m.posterUrl,
                        onTap: () {
                          //ref.read(bookingDraftProvider.notifier).setMovie(m.id);
                          context.go('/movie/${m.id}');
                        },
                        onBookNow: () {
                          //ref.read(bookingDraftProvider.notifier).setMovie(m.id);
                          context.go('/showtimes/${m.id}');
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 18),
                _SectionHeader(
                  title: 'Now Playing',
                  onViewAll: () {},
                ),
                const SizedBox(height: 10),

                // Section thứ 2 giống ảnh (bạn có thể đổi sang Coming Soon)
                SizedBox(
                  height: 240,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final m = movies[index];
                      return _MovieCard(
                        title: m.title,
                        imageUrl: m.posterUrl,
                        onTap: () {
                          //ref.read(bookingDraftProvider.notifier).setMovie(m.id);
                          context.go('/movie/${m.id}');
                        },
                        onBookNow: () {
                          //ref.read(bookingDraftProvider.notifier).setMovie(m.id);
                          context.go('/showtimes/${m.id}');
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TopLocationBar extends StatelessWidget {
  const _TopLocationBar();

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFFF4D67); // đỏ hồng như design

    return Row(
      children: [
        // avatar circle
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE9E9E9),
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your location',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    'Hoa Lac',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.location_on_outlined, size: 18, color: accent),
                ],
              ),
            ],
          ),
        ),

        // bell + dot
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black12),
              ),
              child: const Icon(Icons.notifications_none),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BannerCarousel extends StatelessWidget {
  final List<String> items;
  final ValueChanged<int> onIndexChanged;

  const _BannerCarousel({
    required this.items,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: PageView.builder(
          itemCount: items.length,
          onPageChanged: onIndexChanged,
          itemBuilder: (context, index) {
            final url = items[index];
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
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
  Widget build(BuildContext context) {
    const active = Color(0xFFFF4D67);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 10 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: isActive ? active : Colors.black26,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFFF4D67);

    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const Spacer(),
        InkWell(
          onTap: onViewAll,
          child: Text(
            'View all >',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}

class _MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback onBookNow;

  const _MovieCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
    required this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFFF4D67);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 34,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: accent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  foregroundColor: accent,
                ),
                onPressed: onBookNow,
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  const _HomeBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFFF4D67);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: accent,
      unselectedItemColor: Colors.black38,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: (i) {
        // Sau này bạn map route theo index:
        // 0 Home, 1 Cinemas, 2 My Tickets, 3 Search, 4 Account
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.apps_outlined), label: 'Cinemas'),
        BottomNavigationBarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'My Tickets'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
      ],
    );
  }
}
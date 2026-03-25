import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft.dart';
import 'package:movie_ticket_booking/features/home/presentation/providers/home_providers.dart';
import 'package:movie_ticket_booking/features/checkout/providers/booking_draft_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int bannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final movieAsync = ref.watch(movieProvider);

    return Scaffold(
      // bottomNavigationBar: const _HomeBottomNav(),
      body: SafeArea(
        child: movieAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Error: $e")),
          data: (movies) {
            final banners = movies.take(10).toList();

            final nowPlaying = movies
                .where((m) => m.status == "NOWSHOWING")
                .toList();

            final comingSoon = movies
                .where((m) => m.status == "COMINGSOON")
                .toList();

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 10),

                const _TopLocationBar(),

                const SizedBox(height: 16),

                _BannerCarousel(
                  items: banners
                      .map(
                        (e) =>
                            e.posterUrl ??
                            "https://via.placeholder.com/300x200",
                      )
                      .toList(),
                  onIndexChanged: (i) {
                    setState(() {
                      bannerIndex = i;
                    });
                  },
                ),

                const SizedBox(height: 8),

                _DotsIndicator(count: banners.length, index: bannerIndex),

                const SizedBox(height: 20),

                _SectionHeader(
                  title: "Now Playing",
                  onViewAll: () {
                    context.push('/now-playing');
                  },
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
                        imageUrl:
                            m.posterUrl ?? "https://via.placeholder.com/300",
                        onTap: () {
                          ref.read(bookingDraftProvider.notifier).state =
                              BookingDraft(movie: m.toEntity());

                          context.push('/movies/${m.movieId}');
                        },
                        onBookNow: () {
                          ref.read(bookingDraftProvider.notifier).state =
                              BookingDraft(movie: m.toEntity());

                          context.push('/movies/${m.movieId}/cinemas');
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                _SectionHeader(
                  title: "Coming Soon",
                  onViewAll: () {
                    context.push('/coming-soon');
                  },
                ),

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
                        imageUrl:
                            m.posterUrl ?? "https://via.placeholder.com/300",
                        onTap: () {
                          ref.read(bookingDraftProvider.notifier).state =
                              BookingDraft(movie: m.toEntity());

                          context.push('/movies/${m.movieId}');
                        },
                        onBookNow: () {
                          ref.read(bookingDraftProvider.notifier).state =
                              BookingDraft(movie: m.toEntity());

                          context.push('/movies/${m.movieId}');
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

class _TopLocationBar extends StatelessWidget {
  const _TopLocationBar();

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFFF4D67);

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFEAEAEA),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your location",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.black54),
              ),

              const SizedBox(height: 2),

              Row(
                children: [
                  Text(
                    "Hoa Lac",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 6),

                  const Icon(
                    Icons.location_on_outlined,
                    color: accent,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),

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
                width: 8,
                height: 8,
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
          itemBuilder: (context, index) {
            return Image.network(
              items[index],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                );
              },
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 10 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active ? const Color(0xFFFF4D67) : Colors.black26,
            borderRadius: BorderRadius.circular(100),
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
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),

        const Spacer(),

        InkWell(
          onTap: onViewAll,
          child: Text(
            "View all >",
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
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 34,
              child: OutlinedButton(
                onPressed: onBookNow,
                style: OutlinedButton.styleFrom(
                  foregroundColor: accent,
                  side: const BorderSide(color: accent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Book Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _HomeBottomNav extends StatefulWidget {
//   const _HomeBottomNav();

//   @override
//   State<_HomeBottomNav> createState() => _HomeBottomNavState();
// }

// class _HomeBottomNavState extends State<_HomeBottomNav> {
//   int index = 0;

//   void onTap(int i) {
//     setState(() {
//       index = i;
//     });

//     debugPrint("Bottom navigation clicked: $i");
//   }

//   @override
//   Widget build(BuildContext context) {
//     const accent = Color(0xFFFF4D67);

//     return BottomNavigationBar(
//       currentIndex: index,
//       onTap: onTap,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: accent,
//       unselectedItemColor: Colors.grey,
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),

//         BottomNavigationBarItem(
//           icon: Icon(Icons.grid_view_outlined),
//           label: "Cinemas",
//         ),

//         BottomNavigationBarItem(
//           icon: Icon(Icons.confirmation_number_outlined),
//           label: "My Tickets",
//         ),

//         BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),

//         BottomNavigationBarItem(
//           icon: Icon(Icons.person_outline),
//           label: "Account",
//         ),
//       ],
//     );
//   }
// }

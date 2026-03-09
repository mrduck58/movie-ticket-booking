import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';
import '../providers/search_provider.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  int tabIndex = 0;
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(searchControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,

      body: SafeArea(
        child: vm.when(
          loading: () => const Center(child: CircularProgressIndicator()),

          error: (e, _) => Center(child: Text(e.toString())),

          data: (state) {
            return Column(
              children: [
                /// SEARCH BAR
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              keyword = value;
                            });

                            ref
                                .read(searchControllerProvider.notifier)
                                .searchCinema(value);

                            ref
                                .read(searchControllerProvider.notifier)
                                .searchMovie(value);
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      GestureDetector(
                        onTap: () {
                          context.go('/');
                        },
                        child: const Text(
                          "Huỷ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                /// TAB
                if (keyword.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Tab(
                        text: "Rạp",
                        active: tabIndex == 0,
                        onTap: () {
                          setState(() => tabIndex = 0);
                        },
                      ),

                      const SizedBox(width: 10),

                      _Tab(
                        text: "Phim",
                        active: tabIndex == 1,
                        onTap: () {
                          setState(() => tabIndex = 1);
                        },
                      ),
                    ],
                  ),

                const SizedBox(height: 10),

                /// RESULT
                if (keyword.isNotEmpty)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: tabIndex == 0
                          /// CINEMAS
                          ? ListView.builder(
                              itemCount: state.cinemas.length,
                              itemBuilder: (_, i) {
                                final c = state.cinemas[i];

                                return _CinemaItem(name: c.name);
                              },
                            )
                          /// MOVIES
                          : ListView.builder(
                              itemCount: state.movies.length,
                              itemBuilder: (_, i) {
                                final m = state.movies[i];

                                return _MovieItem(
                                  title: m.title,
                                  poster: m.posterUrl,
                                );
                              },
                            ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;

  const _Tab({required this.text, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary.withOpacity(0.1) : AppColors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: active ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: active ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _CinemaItem extends StatelessWidget {
  final String name;

  const _CinemaItem({required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.movie),
      ),

      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),

      subtitle: const Text(
        "Address cinema...",
        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
      ),

      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: const Text("Suất chiếu"),
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final String title;
  final String poster;

  const _MovieItem({required this.title, required this.poster});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(poster, width: 40, height: 60, fit: BoxFit.cover),
      ),

      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),

      subtitle: Row(
        children: [
          const Text("2026"),

          const SizedBox(width: 6),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Đang chiếu",
              style: TextStyle(fontSize: 11, color: AppColors.success),
            ),
          ),
        ],
      ),

      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: const Text("Đặt vé"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/cinema_providers.dart';

class ChooseCinemaPage extends ConsumerWidget {
  final String movieId; // nhận từ movie detail
  const ChooseCinemaPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(cinemaTabProvider);
    final city = ref.watch(cityProvider);
    final cinemasAsync = ref.watch(cinemasProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        centerTitle: true,
        title: const Text(
          'Choose Cinema',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // location row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Your location',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      // mock dropdown 
                      final selected = await showModalBottomSheet<String>(
                        context: context,
                        showDragHandle: true,
                        builder: (_) => _CityPicker(current: city),
                      );
                      if (selected != null) {
                        ref.read(cityProvider.notifier).state = selected;
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          city,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _TabButton(
                    label: 'All Cinema',
                    isActive: tabIndex == 0,
                    onTap: () => ref.read(cinemaTabProvider.notifier).state = 0,
                  ),
                  const SizedBox(width: 24),
                  _TabButton(
                    label: 'Favorites',
                    isActive: tabIndex == 1,
                    onTap: () => ref.read(cinemaTabProvider.notifier).state = 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            const Divider(height: 1),

            // list
            Expanded(
              child: cinemasAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (cinemas) {
                  final filtered = tabIndex == 0
                      ? cinemas
                      : cinemas.where((c) => c.isFavorite).toList();

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final c = filtered[index];
                      return ListTile(
                        leading: Icon(
                          c.isFavorite ? Icons.star : Icons.star_border,
                          color: c.isFavorite ? Colors.orange : Colors.black45,
                        ),
                        title: Text(
                          c.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // Test
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected cinema: ${c.name} (movieId=$movieId)')),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.primary : Colors.black45,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _CityPicker extends StatelessWidget {
  final String current;
  const _CityPicker({required this.current});

  @override
  Widget build(BuildContext context) {
    final cities = const ['Hung Yen', 'Ha Noi', 'Hoa Lac', 'Da Nang', 'Ho Chi Minh'];

    return ListView(
      children: [
        for (final c in cities)
          ListTile(
            title: Text(c),
            trailing: c == current ? const Icon(Icons.check, color: AppColors.primary) : null,
            onTap: () => Navigator.pop(context, c),
          ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../checkout/presentation/providers/booking_draft_provider.dart';
import '../providers/showtime_providers.dart';
import '../../data/models/showtime_model.dart';

class ChooseDateTimePage extends ConsumerWidget {
  final String movieId;
  final String cinemaId;

  const ChooseDateTimePage({
    super.key,
    required this.movieId,
    required this.cinemaId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showtimesAsync = ref.watch(allShowtimesProvider);
    final selectedDateIndex = ref.watch(selectedDateIndexProvider);
    final selectedTimeKey = ref.watch(selectedTimeKeyProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        centerTitle: true,
        title: const Text(
          'Choose Date and Time',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: showtimesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (all) {
            final filtered = all
                .where((s) => s.movieId == movieId && s.cinemaId == cinemaId)
                .toList();

            final dates = filtered
                .map((s) => DateTime(s.date.year, s.date.month, s.date.day))
                .toSet()
                .toList()
              ..sort((a, b) => a.compareTo(b));

            final idx = dates.isEmpty
                ? 0
                : selectedDateIndex.clamp(0, dates.length - 1);
            final selectedDate = dates.isEmpty ? null : dates[idx];

            final dayShowtimes = selectedDate == null
                ? <ShowtimeModel>[]
                : filtered.where((s) {
                    final d = DateTime(s.date.year, s.date.month, s.date.day);
                    return d == selectedDate;
                  }).toList();

            final standard = dayShowtimes
                .where((s) => s.format.toLowerCase() == 'standard')
                .toList();
            final imax = dayShowtimes
                .where((s) => s.format.toLowerCase() == 'imax')
                .toList();

            // lấy 1 block cho mỗi format
            final standardBlock = standard.isEmpty ? null : standard.first;
            final imaxBlock = imax.isEmpty ? null : imax.first;

            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 110),
                  children: [
                    // Map preview 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        height: 140,
                        color: Colors.black12,
                        alignment: Alignment.center,
                        child: const Text('Map preview'),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Cinema info 
                    const Text(
                      'AMC Empire 25',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        _StarRow(stars: 5),
                        SizedBox(width: 8),
                        Text('4.1', style: TextStyle(fontWeight: FontWeight.w700)),
                        SizedBox(width: 6),
                        Text('(10,771 Google reviews)',
                            style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.place_outlined, size: 18, color: Colors.black54),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '234 W 42nd St, New York, NY 10036, United States',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.phone_outlined, size: 18, color: Colors.black54),
                        SizedBox(width: 6),
                        Text('+1 212-398-2597',
                            style: TextStyle(color: Colors.black54)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Date chips row
                    SizedBox(
                      height: 70,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, i) {
                          final d = dates[i];
                          final isActive = i == idx;
                          return _DateChip(
                            date: d,
                            isActive: isActive,
                            onTap: () {
                              ref.read(selectedDateIndexProvider.notifier).set(i);
                              ref.read(selectedTimeKeyProvider.notifier).clear();
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    if (standardBlock != null) ...[
                      _FormatRow(
                        format: 'Standard',
                        priceText: _formatUsd(standardBlock.price),
                        auditorium: standardBlock.auditorium,
                      ),
                      const SizedBox(height: 10),
                      _TimeWrap(
                        times: standardBlock.times,
                        format: 'Standard',
                        selectedKey: selectedTimeKey,
                        onSelect: (key) => ref
                            .read(selectedTimeKeyProvider.notifier)
                            .select(key),
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (imaxBlock != null) ...[
                      _FormatRow(
                        format: 'IMAX',
                        priceText: _formatUsd(imaxBlock.price),
                        auditorium: imaxBlock.auditorium,
                      ),
                      const SizedBox(height: 10),
                      _TimeWrap(
                        times: imaxBlock.times,
                        format: 'IMAX',
                        selectedKey: selectedTimeKey,
                        onSelect: (key) => ref
                            .read(selectedTimeKeyProvider.notifier)
                            .select(key),
                      ),
                    ],
                  ],
                ),

                // Bottom Continue button fixed
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: SizedBox(
                    height: 52,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: selectedTimeKey == null
                          ? null
                          : () {
                              if (selectedDate == null) return;

                              // key = "Standard|17:30"
                              final parts = selectedTimeKey.split('|');
                              if (parts.length != 2) return;

                              final format = parts[0];
                              final time = parts[1];

                              final chosenBlock =
                                  (format.toLowerCase() == 'imax')
                                      ? imaxBlock
                                      : standardBlock;

                              if (chosenBlock == null) return;

                              // lưu vào draft
                              ref
                                  .read(bookingDraftProvider.notifier)
                                  .setShowtimeDetail(
                                    cinemaId: cinemaId,
                                    showtimeId: chosenBlock.id,
                                    date: selectedDate,
                                    format: format,
                                    time: time,
                                    seatPrice: chosenBlock.price,
                                  );

                              // đi sang màn chọn ghế
                              context.go('/seats/${chosenBlock.id}');
                            },
                      child: const Text(
                        'Continue',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
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

  String _formatUsd(double value) =>
      NumberFormat.currency(symbol: r'$', decimalDigits: 2).format(value);
}

class _StarRow extends StatelessWidget {
  final int stars;
  const _StarRow({required this.stars});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        stars,
        (_) => const Icon(Icons.star, size: 16, color: Colors.amber),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  final DateTime date;
  final bool isActive;
  final VoidCallback onTap;

  const _DateChip({
    required this.date,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;

    final day = DateFormat('dd').format(date);
    final sub = isToday ? 'Today' : DateFormat('EEE').format(date);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 58,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: isActive ? AppColors.primary : Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: isActive ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              sub,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isActive ? Colors.white : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormatRow extends StatelessWidget {
  final String format;
  final String priceText;
  final String auditorium;

  const _FormatRow({
    required this.format,
    required this.priceText,
    required this.auditorium,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(format,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
        const SizedBox(width: 6),
        Text('($priceText)',
            style: const TextStyle(
                color: Colors.black45, fontWeight: FontWeight.w700)),
        const Spacer(),
        Text(auditorium,
            style: const TextStyle(
                color: Colors.black45, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _TimeWrap extends StatelessWidget {
  final List<String> times;
  final String format;
  final String? selectedKey;
  final ValueChanged<String> onSelect;

  const _TimeWrap({
    required this.times,
    required this.format,
    required this.selectedKey,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: times.map((t) {
        final key = '$format|$t';
        final isSelected = key == selectedKey;

        return SizedBox(
          width: 66,
          height: 36,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: isSelected ? AppColors.primary : Colors.white,
              foregroundColor: isSelected ? Colors.white : Colors.black87,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.black12),
              padding: EdgeInsets.zero,
            ),
            onPressed: () => onSelect(key),
            child: Text(t, style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        );
      }).toList(),
    );
  }
}
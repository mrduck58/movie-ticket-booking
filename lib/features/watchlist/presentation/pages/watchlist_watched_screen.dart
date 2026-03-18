import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie.dart';
import '../providers/watchlist_providers.dart';

class WatchlistWatchedScreen extends ConsumerStatefulWidget {
  const WatchlistWatchedScreen({super.key});

  @override
  ConsumerState<WatchlistWatchedScreen> createState() =>
      _WatchlistWatchedScreenState();
}

class _WatchlistWatchedScreenState extends ConsumerState<WatchlistWatchedScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFE53935);

    final vm = ref.watch(watchlistControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
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
          "Watchlist",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: Column(
            children: [
              TabBar(
                controller: _tab,
                labelColor: red,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                indicatorColor: red,
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: "Watchlist"),
                  Tab(text: "Watched"),
                ],
              ),
              Container(height: 1, color: Colors.grey.shade200),
            ],
          ),
        ),
      ),
      body: vm.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Error: $e',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (data) => TabBarView(
          controller: _tab,
          children: [
            _WatchlistGrid(items: data.watchlist),
            _WatchedList(items: data.watched),
          ],
        ),
      ),
    );
  }
}

/// =======================================
/// TAB 1: WATCHLIST (Grid 2 cột)
/// - Nút full width theo card
/// - Thêm bottom padding để không bị che
/// =======================================
class _WatchlistGrid extends StatelessWidget {
  final List<Movie> items;
  const _WatchlistGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFE53935);

    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const crossAxisCount = 2;
          const crossAxisSpacing = 18.0;
          const mainAxisSpacing = 18.0;

          // ✅ tăng bottom padding thêm chút để item cuối chắc chắn không bị che
          final padding = EdgeInsets.fromLTRB(18, 18, 18, 28 + bottomInset);

          final gridWidth = constraints.maxWidth - padding.horizontal;

          final itemWidth =
              (gridWidth - (crossAxisCount - 1) * crossAxisSpacing) /
                  crossAxisCount;

          final posterHeight = itemWidth * (4.2 / 3.0);

          const gap1 = 10.0;
          const titleHeight = 20.0;
          const gap2 = 10.0;

          // ✅ pill sẽ full width nên height thực tế ổn định hơn
          const pillHeight = 32.0;

          final itemHeight =
              posterHeight + gap1 + titleHeight + gap2 + pillHeight;

          final childAspectRatio = itemWidth / itemHeight;

          return Padding(
            padding: padding,
            child: GridView.builder(
              itemCount: items.length,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                childAspectRatio: childAspectRatio,
              ),
              itemBuilder: (_, i) {
                final m = items[i];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Poster
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: posterHeight,
                        width: double.infinity,
                        child: Image.network(
                          m.posterUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: gap1),

                    // Title
                    SizedBox(
                      height: titleHeight,
                      child: Text(
                        m.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: gap2),

                    // ✅ Pill button FULL WIDTH bằng movie card
                    SizedBox(
                      height: pillHeight,
                      width: double.infinity,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.black12, width: 1),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.favorite, color: red, size: 16),
                            SizedBox(width: 7),
                            Text(
                              "Watchlist",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

/// =======================================
/// TAB 2: WATCHED (List item) - 2 cột thẳng hàng
/// =======================================
class _WatchedList extends StatelessWidget {
  final List<Movie> items;
  const _WatchedList({required this.items});

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFE53935);

    return SafeArea(
      top: false,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 22),
        itemBuilder: (_, i) {
          final m = items[i];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 120,
                      height: 170,
                      child: Image.network(m.posterUrl, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _MetaRow(label: "Duration", value: m.durationMin.toString() ?? "-" ),
                        const SizedBox(height: 6),
                        _MetaRow(label: "Director", value: m.director ?? "-"),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _MetaLabelOnly(label: "AR"),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: red, width: 1),
                                color: Colors.white,
                              ),
                              child: Text(
                                m.rating?.toString() ?? "R13+",
                                style: const TextStyle(
                                  color: red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _MetaLabelOnly(label: "Genre"),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                (m.genres ?? const []).join(",\n"),
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.45,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: Colors.black12, width: 1),
                  color: Colors.white,
                ),
                child: const Center(
                  child: Text(
                    "Watched",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MetaLabelOnly extends StatelessWidget {
  final String label;
  const _MetaLabelOnly({required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;
  const _MetaRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetaLabelOnly(label: label),
        Text(
          ": ",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
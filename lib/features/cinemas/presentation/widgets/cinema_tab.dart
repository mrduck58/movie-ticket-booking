import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

import '../../data/models/cineme_tab.dart';
import 'tab_item.dart';

class CinemaTabs extends StatelessWidget {
  const CinemaTabs({required this.tab, required this.onChanged});

  final CinemaTab tab;
  final ValueChanged<CinemaTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
      child: Row(
        children: [
          TabItem(
            title: "All Cinema",
            active: tab == CinemaTab.all,
            onTap: () => onChanged(CinemaTab.all),
          ),

          //const SizedBox(width: 24),

          TabItem(
            title: "Favorites",
            active: tab == CinemaTab.favorites,
            onTap: () => onChanged(CinemaTab.favorites),
          ),
        ],
      ),
    );
  }
}
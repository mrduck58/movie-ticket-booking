import 'package:flutter/material.dart';

class TicketTabs extends StatelessWidget {
  final int tabIndex;
  final Function(int) onChanged;

  const TicketTabs({
    super.key,
    required this.tabIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _tabItem("Upcoming", 0),
        const SizedBox(width: 40),
        _tabItem("Passed", 1),
      ],
    );
  }

  Widget _tabItem(String title, int index) {
    bool active = tabIndex == index;

    return GestureDetector(
      onTap: () => onChanged(index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: active ? Colors.red : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 3,
            width: 60,
            color: active ? Colors.red : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
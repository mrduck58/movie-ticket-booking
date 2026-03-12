import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {

  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [

          Icon(icon, size: 20, color: Colors.grey),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
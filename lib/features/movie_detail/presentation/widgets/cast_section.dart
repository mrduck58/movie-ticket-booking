import 'package:flutter/material.dart';

class CastSection extends StatelessWidget {
  final List cast;

  const CastSection({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Cast",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

        const SizedBox(height: 12),

        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (_, i) {
              final actor = cast[i];

              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(actor.imageUrl),
                    ),
                    const SizedBox(height: 6),
                    Text(actor.name, style: const TextStyle(fontSize: 12))
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
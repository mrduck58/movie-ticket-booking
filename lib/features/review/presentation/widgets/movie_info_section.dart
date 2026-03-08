import 'package:flutter/material.dart';

class MovieInfoSection extends StatelessWidget {

  final String title;

  const MovieInfoSection({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/mock/movie.jpg",
            width: 100,
            height: 140,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              const Text("Duration : 134 minutes"),
              const Text("Director : Nia DaCosta"),
              const Text("AR : R13+"),

              const SizedBox(height: 6),

              const Text(
                "Genre : Action, Fantasy, Adventure",
              ),
            ],
          ),
        )
      ],
    );
  }
}
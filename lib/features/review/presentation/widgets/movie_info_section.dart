import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/core/theme/app_colors.dart';

class MovieInfoSection extends StatelessWidget {
  final String title;
  final String duration;
  final String director;
  final String rating;
  final String genre;
  final String poster;

  const MovieInfoSection({
    super.key,
    required this.title,
    required this.duration,
    required this.director,
    required this.rating,
    required this.genre,
    required this.poster,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// POSTER
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            poster,
            width: 160,
            height: 240,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(width: 20),

        /// INFO
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 14),

              /// INFO GRID
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                children: [
                  _row("Duration", ": $duration min"),

                  _row("Director", ": $director"),

                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          "Rating",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              rating,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  _row("Genre", ": $genre"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

TableRow _row(String label, String value) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    ],
  );
}

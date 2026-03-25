import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/movie_detail/data/datasources/rate_movie_service.dart';

Future<bool?> showRatingDialog(BuildContext context, String movieId) {
  int stars = 0;

  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Rate this movie",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      icon: Icon(
                        index < stars ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 34,
                      ),
                      onPressed: () {
                        setState(() {
                          stars = index + 1;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (stars == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select stars")),
                        );
                        return;
                      }

                      await RateMovieService().rate(
                        movieId: movieId,
                        stars: stars,
                      );

                      Navigator.pop(context, true); // 🔥 quan trọng

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Rating submitted")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e")),
                      );
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../checkout/providers/booking_draft_provider.dart';

class MovieDetailPage extends ConsumerWidget {
  final String movieId;

  const MovieDetailPage({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Detail"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            const Text(
              "Jujutsu Kaisen",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Action • Fantasy • Adventure",
            ),

            const SizedBox(height: 20),

            const Text(
              "This is a demo movie detail page used "
              "to start the booking flow.",
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 54,

              child: ElevatedButton(
                onPressed: () {

                  /// tạo booking draft
                  //ref.read(bookingDraftProvider.notifier).state =
                      //BookingDraft(movieId: movieId);

                  /// chuyển sang choose cinema
                  context.go('/choose-cinema/$movieId');
                },

                child: const Text("Book Ticket"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
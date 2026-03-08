import 'package:go_router/go_router.dart';

import '../features/home/presentation/pages/home_page.dart';
import '../features/movie_detail/presentation/pages/movie_detail_page.dart';
import '../features/cinemas/presentation/pages/choose_cinema_page.dart';
import '../features/showtimes/presentation/pages/choose_showtime_page.dart';
import '../features/review/presentation/pages/review_summary_page.dart';
import '../features/payment/presentation/pages/choose_payment_page.dart';
import '../features/seat_selection/presentation/pages/seat_selection_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'movie/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return MovieDetailPage(movieId: id);
            },
          ),
          GoRoute(
            path: 'choose-cinema/:movieId',
            builder: (context, state) {
              final movieId = state.pathParameters['movieId']!;
              return ChooseCinemaPage(movieId: movieId);
            },
          ),
          GoRoute(
            path: 'showtimes/:movieId/:cinemaId',
            builder: (context, state) {
              final movieId = state.pathParameters['movieId']!;
              final cinemaId = state.pathParameters['cinemaId']!;
              return ChooseShowtimePage(movieId: movieId, cinemaId: cinemaId);
            },
          ),
          GoRoute(
            path: 'seat-selection/:movieId/:cinemaId/:showtime',
            builder: (context, state) {
              final movieId = state.pathParameters['movieId']!;
              final cinemaId = state.pathParameters['cinemaId']!;
              final showtime = state.pathParameters['showtime']!;

              return SeatSelectionPage(
                movieId: movieId,
                cinemaId: cinemaId,
                showtimeId: showtime,
              );
            },
          ),
          GoRoute(
            path: 'review',
            builder: (context, state) => const ReviewSummaryPage(),
          ),
          GoRoute(
            path: 'payment-method',
            builder: (context, state) => const ChoosePaymentPage(),
          ),
        ],
      ),
    ],
  );
}

import 'package:go_router/go_router.dart';

import '../features/home/presentation/pages/home_page.dart';
import '../features/movie_detail/presentation/pages/movie_detail_page.dart';
import '../features/showtimes/presentation/pages/showtimes_page.dart';
import '../features/seat_selection/presentation/pages/seat_selection_page.dart';
import '../features/checkout/presentation/pages/checkout_page.dart';

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
            path: 'showtimes/:movieId',
            builder: (context, state) {
              final movieId = state.pathParameters['movieId']!;
              return ShowtimesPage(movieId: movieId);
            },
          ),
          GoRoute(
            path: 'seats/:showtimesId',
            builder: (context, state) {
              final showtimesId = state.pathParameters['showtimesId']!;
              return SeatSelectionPage(showtimesId: showtimesId);
            },
          ),
          GoRoute(
            path: 'checkout',
            builder: (context, state) => const CheckoutPage(),
          ),
        ],
      ),
    ],
  );
}

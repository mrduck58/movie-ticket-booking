import 'package:go_router/go_router.dart';

import 'package:movie_ticket_booking/features/account/presentation/pages/account_screen.dart';
import 'package:movie_ticket_booking/features/search/presentation/pages/search_page.dart';
import 'package:movie_ticket_booking/features/watchlist/presentation/pages/watchlist_watched_screen.dart';
import 'package:movie_ticket_booking/features/payment_method/presentation/pages/payment_method_screen.dart';
import 'package:movie_ticket_booking/features/notification/presentation/pages/notification_screen.dart';

import '../core/widgets/layouts/navigation_bar.dart';

import '../features/home/presentation/pages/home_page.dart';
import '../features/movie_detail/presentation/pages/movie_detail_page.dart';
import '../features/cinemas/presentation/pages/choose_cinema_page.dart';
import '../features/showtimes/presentation/pages/choose_showtime_page.dart';
import '../features/review/presentation/pages/review_summary_page.dart';
import '../features/payment/presentation/pages/choose_payment_page.dart';
import '../features/seat_selection/presentation/pages/seat_selection_page.dart';
import '../features/review/presentation/pages/booking_detail_page.dart';
import 'package:movie_ticket_booking/features/home/presentation/pages/now_playing.dart';
import 'package:movie_ticket_booking/features/home/presentation/pages/coming_soon.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [

      /// MAIN LAYOUT (BottomNavigationBar)
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [

          /// HOME
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),

          /// NOW PLAYING
          GoRoute(
            path: '/now-playing',
            builder: (context, state) => const NowPlayingPage(),
          ),

          /// COMING SOON
          GoRoute(
            path: '/coming-soon',
            builder: (context, state) => const ComingSoonPage(),
          ),

          /// ACCOUNT
          GoRoute(
            path: '/account',
            builder: (context, state) => const AccountScreen(),
          ),

          /// WATCHLIST
          GoRoute(
            path: '/watchlist',
            builder: (context, state) => const WatchlistWatchedScreen(),
          ),

          /// SEARCH
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchPage(),
          ),

          /// NOTIFICATIONS
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const NotificationScreen(),
          ),

          GoRoute(
            path: '/booking-detail',
            builder: (context, state) => const BookingDetailPage(),
          ),
        ],
      ),

      /// MOVIE DETAIL (không có bottom nav)
      GoRoute(
        path: '/movie/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MovieDetailPage(movieId: id);
        },
      ),

      /// BOOKING FLOW

      GoRoute(
        path: '/choose-cinema/:movieId',
        builder: (context, state) {
          final movieId = state.pathParameters['movieId']!;
          return ChooseCinemaPage(movieId: movieId);
        },
      ),

      GoRoute(
        path: '/showtimes/:movieId/:cinemaId',
        builder: (context, state) {
          final movieId = state.pathParameters['movieId']!;
          final cinemaId = state.pathParameters['cinemaId']!;

          return ChooseShowtimePage(
            movieId: movieId,
            cinemaId: cinemaId,
          );
        },
      ),

      GoRoute(
        path: '/seat-selection/:movieId/:cinemaId/:showtime',
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
        path: '/review',
        builder: (context, state) => const ReviewSummaryPage(),
      ),

      GoRoute(
        path: '/payment-method',
        builder: (context, state) => const ChoosePaymentPage(),
      ),

      GoRoute(
        path: '/payment-methods',
        builder: (context, state) => const ChoosePaymentMethodScreen(),
      ),
    ],
  );
}
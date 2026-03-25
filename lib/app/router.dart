import 'package:go_router/go_router.dart';

import 'package:movie_ticket_booking/features/account/presentation/pages/account_screen.dart';
import 'package:movie_ticket_booking/features/food_combo/presentation/pages/choose_combo.dart';
import 'package:movie_ticket_booking/features/account/presentation/pages/screens/account_screen.dart';
import 'package:movie_ticket_booking/features/profile/presentation/pages/my_profile.dart';
import 'package:movie_ticket_booking/features/search/presentation/pages/screens/search_page.dart';
import 'package:movie_ticket_booking/features/ticket/presentation/pages/my_ticket.dart';
import 'package:movie_ticket_booking/features/watchlist/presentation/pages/screens/watchlist_watched_screen.dart';
import 'package:movie_ticket_booking/features/payment_method/presentation/pages/payment_method_screen.dart';
import 'package:movie_ticket_booking/features/notification/presentation/pages/screens/notification_screen.dart';
import 'package:movie_ticket_booking/features/register/presentation/pages/create_account.dart';
import 'package:movie_ticket_booking/features/register/presentation/pages/movie_interest_screen.dart';
import 'package:movie_ticket_booking/features/login/presentation/pages/login_screen.dart';
import 'package:movie_ticket_booking/features/account/presentation/pages/screens/help_center_screen.dart';
import 'package:movie_ticket_booking/features/account/presentation/pages/screens/about_app_screen.dart';
import '../core/widgets/layouts/navigation_bar.dart';
import '../features/login/presentation/pages/intro_2.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/movie_detail/presentation/pages/movie_detail_page.dart';
import '../features/cinemas/presentation/pages/choose_cinema_page.dart';
import '../features/showtimes/presentation/pages/choose_showtime_page.dart';
import '../features/review/presentation/pages/review_summary_page.dart';
import '../features/payment/presentation/pages/choose_payment_page.dart';
import '../features/seat_selection/presentation/pages/seat_selection_page.dart';
import '../features/review/presentation/pages/booking_detail_page.dart';
import '../features/register/presentation/pages/complete_profile.dart';
import 'package:movie_ticket_booking/features/home/presentation/pages/now_playing.dart';
import 'package:movie_ticket_booking/features/home/presentation/pages/coming_soon.dart';
import '../features/register/presentation/pages/verify_otp_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/intro',
    routes: [
      /// MAIN LAYOUT (BottomNavigationBar)
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          /// HOME
          GoRoute(path: '/', builder: (context, state) => const HomePage()),

          /// CINEMAS TAB
          // GoRoute(
          //   path: '/cinemas',
          //   builder: (context, state) => const ChooseCinemaPage(),
          // ),

          //MY TICKETS TAB
          GoRoute(
            path: '/tickets',
            builder: (context, state) => const MyTicketsPage(),
          ),

          /// SEARCH TAB
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchPage(),
          ),

          /// ACCOUNT TAB
          GoRoute(
            path: '/account',
            builder: (context, state) => const AccountScreen(),
          ),
        ],
      ),

      /// OTHER PAGES (không có bottom nav)
      GoRoute(
        path: '/watchlist',
        builder: (context, state) => const WatchlistWatchedScreen(),
      ),

      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationScreen(),
      ),

      // GoRoute(
      //   path: '/booking-detail',
      //   builder: (context, state) => const BookingDetailPage(),
      // ),
      GoRoute(
        path: '/now-playing',
        builder: (context, state) => const NowPlayingPage(),
      ),

      GoRoute(
        path: '/coming-soon',
        builder: (context, state) => const ComingSoonPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileInfoScreen(),
      ),

      /// MOVIE DETAIL (không có bottom nav)
      GoRoute(
        path: '/movies/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MovieDetailPage(movieId: id);
        },
      ),

      /// BOOKING FLOW
      GoRoute(
        path: '/movies/:movieId/cinemas',
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

          return ChooseShowtimePage(movieId: movieId, cinemaId: cinemaId);
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
        path: '/combos',
        builder: (context, state) {
          return FoodOrderPage();
        },
      ),

      GoRoute(
        path: '/review',
        builder: (context, state) => const ReviewSummaryPage(),
      ),

      // GoRoute(
      //   path: '/review',
      //   builder: (context, state) => const ReviewSummaryPage(),
      // ),
      GoRoute(
        path: '/payment-method',
        builder: (context, state) => const ChoosePaymentPage(),
      ),

      GoRoute(
        path: '/payment-methods',
        builder: (context, state) => const ChoosePaymentMethodScreen(),
      ),
      GoRoute(path: '/intro', builder: (context, state) => const Intro2()),

      GoRoute(
        path: '/create-account',
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/complete-profile',
        builder: (context, state) => const CompleteProfileScreen(),
      ),
      GoRoute(
        path: '/movie-interest',
        builder: (context, state) => const MovieInterestScreen(),
      ),
      GoRoute(
        path: '/help-center',
        builder: (context, state) => const HelpCenterScreen(),
      ),
      GoRoute(
        path: '/about-app',
        builder: (context, state) => const AboutAppScreen(),
      ),
      GoRoute(
        path: '/verify-otp',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return VerifyOtpScreen(data: args);
        },
      ),
    ],
  );
}

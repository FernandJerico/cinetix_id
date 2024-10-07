import 'package:cinetix_id/domain/entities/movie.dart';
import 'package:cinetix_id/domain/entities/movie_detail.dart';
import 'package:cinetix_id/presentation/pages/booking-confirmation/booking_confirmation_page.dart';
import 'package:cinetix_id/presentation/pages/login/login_page.dart';
import 'package:cinetix_id/presentation/pages/main_page/main_page.dart';
import 'package:cinetix_id/presentation/pages/movie/detail_movie_page.dart';
import 'package:cinetix_id/presentation/pages/seat-booking/seat_booking_page.dart';
import 'package:cinetix_id/presentation/pages/time_booking/time_booking_page.dart';
import 'package:cinetix_id/presentation/pages/wallet/wallet_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/transaction.dart';
import '../../pages/register/register_page.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(routes: [
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) => DetailMoviePage(
          movie: state.extra as Movie,
        ),
      ),
      GoRoute(
        path: '/time-booking',
        name: 'time-booking',
        builder: (context, state) => TimeBookingPage(
          movieDetail: state.extra as MovieDetail,
        ),
      ),
      GoRoute(
        path: '/seat-booking',
        name: 'seat-booking',
        builder: (context, state) => SeatBookingPage(
          transactionDetail: state.extra as (MovieDetail, Transaction),
        ),
      ),
      GoRoute(
        path: '/booking-confirmation',
        name: 'booking-confirmation',
        builder: (context, state) => BookingConfirmationPage(
          transactionDetail: state.extra as (MovieDetail, Transaction),
        ),
      ),
      GoRoute(
        path: '/wallet',
        name: 'wallet',
        builder: (context, state) => const WalletPage(),
      ),
    ], initialLocation: '/login', debugLogDiagnostics: false);

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// Current pages (will be moved to features/ soon)
import '../../TonBudget.dart';
import '../../total.dart';
import '../../aboutUs.dart';
import '../../splashscreen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/budget',
        name: 'budget',
        builder: (context, state) => const TonBudget(),
      ),
      GoRoute(
        path: '/total',
        name: 'total',
        builder: (context, state) => const Total(),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutUs(),
      ),
    ],
  );
}

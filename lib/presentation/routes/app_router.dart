// routes/app_router.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/university.dart'; // ← import your model
import '../views/home_screen.dart';
import '../views/detail_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/detail',
        name: 'detail', // ← name it here
        builder: (context, state) {
          final uni = state.extra as University;
          return DetailScreen(university: uni);
        },
      ),
    ],
  );
});

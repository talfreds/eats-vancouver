import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/auth_screen.dart';
import '../../features/discovery/screens/discovery_screen.dart';
import '../../features/detail/screens/detail_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final isSignedIn = ref.watch(isSignedInProvider);

  return GoRouter(
    initialLocation: isSignedIn ? '/feed' : '/',
    redirect: (context, state) {
      final signedIn = ref.read(isSignedInProvider);
      final onAuth = state.matchedLocation == '/';

      if (!signedIn && !onAuth) return '/';
      if (signedIn && onAuth) return '/feed';
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/feed',
        name: 'feed',
        builder: (context, state) => const DiscoveryScreen(),
      ),
      GoRoute(
        path: '/restaurant/:id',
        name: 'detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DetailScreen(restaurantId: id);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
});

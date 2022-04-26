import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/widgets/screens/home_screen/home_screen.dart';
import 'package:projex_app/widgets/screens/login_screen/login_screen.dart';

// This provider sets up goRouter
// The routes supported are
//    '/': this is the route for the main view
//    '/login': this is the route for the login/signup page
//
// A redirect has been setup such that when the auth state changes
// The router automatically changes to the appropraite view.

final routerProvider = Provider<GoRouter>(
  (ref) {
    final auth = ref.watch(authProvider.notifier);
    return GoRouter(
      urlPathStrategy: UrlPathStrategy.path,
      refreshListenable: auth,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
      ],
      redirect: (state) {
        // if the user is not logged in, they need to login
        final isLoggingIn = state.subloc == '/login';
        if (auth.isNotLoggedIn) {
          return isLoggingIn ? null : '/login';
        }

        // if the user is logged in but still on the login page, send them to
        // the home page
        if (isLoggingIn) {
          return '/';
        }

        // no need to redirect at all
        return null;
      },
    );
  },
);

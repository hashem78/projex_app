import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/first_time_sign_in/first_time_sign_in_screen.dart';
import 'package:projex_app/screens/home/home_screen.dart';
import 'package:projex_app/screens/login/login_screen.dart';
import 'package:projex_app/screens/profile/profile_screen.dart';
import 'package:projex_app/screens/settings/settings_screen.dart';
import 'package:projex_app/state/auth.dart';

/// This provider sets up goRouter
/// The routes supported are
///
///    '/': this is the route for the main view
///
///    -> 'settings': the user's settings page
///
///    '/login': this is the route for the login/signup page
///
/// A redirect has been setup such that when the auth state changes
/// The router automatically changes to the appropraite view.

final routerProvider = Provider<GoRouter>(
  (ref) {
    final auth = ref.watch(authProvider.notifier);

    return GoRouter(
      debugLogDiagnostics: true,
      urlPathStrategy: UrlPathStrategy.path,
      refreshListenable: auth,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          redirect: (state) {
            if (auth.isFirstTime) {
              return '/firstTime';
            }
            return null;
          },
          routes: [
            GoRoute(
              path: 'firstTime',
              name: 'firstTime',
              builder: (context, state) => const FirstTimeSignInScreen(),
            ),
            GoRoute(
              path: 'profile/:uid',
              builder: (context, state) {
                return ProfileScreen(uid: state.params['uid']!);
              },
            ),
            GoRoute(
              path: 'settings',
              name: 'settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
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

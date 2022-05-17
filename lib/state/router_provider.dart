import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/screens/add_members/add_members_screen.dart';
import 'package:projex_app/screens/add_roles_to_user/add_roles_to_user_screen.dart';
import 'package:projex_app/screens/create_project/create_project_screen.dart';
import 'package:projex_app/screens/edit_roles/edit_roles_screen.dart';
import 'package:projex_app/screens/project/project_screen.dart';
import 'package:projex_app/screens/home/home_screen.dart';
import 'package:projex_app/screens/login/login_screen.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';

/// This provider sets up goRouter.
///
/// The routes supported are
///   ```dart
///     => /
///     =>   /profile
///     =>   /profile/:uid
///     =>   /settings
///     =>   /createProject
///     =>   /project
///     =>     /project/addMembers
///     =>     /project/addRolesToUser
///     => /login
///
///```
/// A redirect has been setup such that when the auth state changes
/// The router automatically changes to the appropraite view.

final routerProvider = Provider<GoRouter>(
  (ref) {
    final auth = ref.watch(authProvider.notifier);

    return GoRouter(
      debugLogDiagnostics: true,
      urlPathStrategy: UrlPathStrategy.path,
      refreshListenable: GoRouterRefreshStream(auth.stream),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'profile/:uid',
              builder: (context, state) {
                return const HomeScreen();
              },
            ),
            GoRoute(
              path: 'createProject',
              builder: (context, state) => const CreateProjectScreen(),
            ),
            GoRoute(
              path: 'project/:pid',
              builder: (context, state) {
                return ProviderScope(
                  overrides: [
                    selectedProjectProvider.overrideWithValue(state.params['pid']!),
                  ],
                  child: const ProjectScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'addMembers',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                      ],
                      child: const AddMembersScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'addRolesToUser',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                      ],
                      child: AddRolesToUserScreen(
                        uid: state.queryParams['uid']!,
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: 'editRole',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                      ],
                      child: EditRoleScreen(
                        roleId: state.queryParams['roleId']!,
                      ),
                    );
                  },
                ),
              ],
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

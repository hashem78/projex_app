import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/chat/group_chat_screen.dart';
import 'package:projex_app/screens/edit_chat_group/edit_chat_group_screen.dart';
import 'package:projex_app/screens/feeback/feedback_screen.dart';
import 'package:projex_app/screens/sub_task/sub_task_screen.dart';
import 'package:projex_app/screens/invite_members/invite_members_screen.dart';
import 'package:projex_app/screens/add_roles_to_user/add_roles_to_user_screen.dart';
import 'package:projex_app/screens/create_project/create_project_screen.dart';
import 'package:projex_app/screens/edit_roles/edit_roles_screen.dart';
import 'package:projex_app/screens/chat/m2m_chat_screen.dart';
import 'package:projex_app/screens/pending_invitations/pending_invitations_screen.dart';
import 'package:projex_app/screens/profile/profile_screen.dart';
import 'package:projex_app/screens/project/project_screen.dart';
import 'package:projex_app/screens/home/home_screen.dart';
import 'package:projex_app/screens/login/login_screen.dart';
import 'package:projex_app/screens/project_settings/project_settings_screen.dart';
import 'package:projex_app/screens/review_join_requests/review_join_requests_screen.dart';
import 'package:projex_app/screens/task/task_screen.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/go_router_refresh_stream.dart';
import 'package:projex_app/state/group_chat.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';
import 'package:projex_app/state/user_provider.dart';

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
///     =>     /project/inviteMembers
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
      refreshListenable: GoRouterRefreshStream(auth.stream),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'profile/:uid',
              builder: (context, state) {
                return ProviderScope(
                  overrides: [selectedUserProvider.overrideWithValue(state.params['uid']!)],
                  child: const ProfileScreen(),
                );
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
                  path: 'task/:tid',
                  routes: [
                    GoRoute(
                      path: 'feedback',
                      builder: (context, state) {
                        return ProviderScope(
                          overrides: [
                            selectedTaskProvider.overrideWithValue(state.params['tid']!),
                            selectedProjectProvider.overrideWithValue(state.params['pid']!),
                          ],
                          child: const FeedBackScreen(),
                        );
                      },
                    ),
                    GoRoute(
                      path: 'subTask/:subTid',
                      builder: (context, state) {
                        return ProviderScope(
                          overrides: [
                            selectedTaskProvider.overrideWithValue(state.params['tid']!),
                            selectedSubTaskProvider.overrideWithValue(state.params['subTid']!),
                            selectedProjectProvider.overrideWithValue(state.params['pid']!),
                          ],
                          child: const SubTaskScreen(),
                        );
                      },
                    ),
                  ],
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedTaskProvider.overrideWithValue(state.params['tid']!),
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                      ],
                      child: const TaskScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'settings',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                      ],
                      child: const ProjectSettingsScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'groupChat/:gid',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                        selectedGroupProvider.overrideWithValue(state.params['gid']!),
                      ],
                      child: const GroupChatScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'editChatGroup/:gid',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                        selectedGroupProvider.overrideWithValue(state.params['gid']!),
                      ],
                      child: const EditChatGroupScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'chatWith/:uid',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedUserProvider.overrideWithValue(state.params['uid']!),
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                      ],
                      child: const M2MChatScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'reviewJoinRequests',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                      ],
                      child: const ReviewJoinRequestsScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'pendingInvitations',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                      ],
                      child: const PendingInvitationsScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'inviteMembers',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                      ],
                      child: const InviteMembersScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'addRolesToUser',
                  builder: (context, state) {
                    return ProviderScope(
                      overrides: [
                        selectedProjectProvider.overrideWithValue(state.params['pid']!),
                        selectedUserProvider.overrideWithValue(state.queryParams['uid']!),
                      ],
                      child: const AddRolesToUserScreen(),
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
      redirect: (context, state) {
        // if the user is not logged in, they need to login
        final isLoggingIn = state.subloc == '/login';
        final isNotLoggedIn = FirebaseAuth.instance.currentUser == null;
        if (isNotLoggedIn) {
          return isLoggingIn ? null : '/login';
        }

        // if the user is logged in but still on the login page, send them to
        // the home page
        if (isLoggingIn) {
          return '/login';
        }
        
        // no need to redirect at all
        return null;
      },
    );
  },
);

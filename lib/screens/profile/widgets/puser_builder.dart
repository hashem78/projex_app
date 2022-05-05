import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/state/auth.dart';

/// Obtains a PUser instance from a uid or from the currently logged in user
/// and provides optional builders for data, error and loading states
///
/// Usage example to obtain the currently logged in user
/// ```dart
///   PUserBuilder.fromCurrent(
///           // user is provided as a builder argument
///            builder: (context, user) => GestureDetector(
///              onTap: () {
///                context.go('/profile/${user.id}');
///              },
///              child: UserAccountsDrawerHeader(
///                currentAccountPicture: ProfileScreenImage(
///                  user: user,
///                  borderWidth: 2,
///                ),
///                accountName: Column(
///                  children: [
///                    ...
///                  ],
///                ),
///                accountEmail: Text(user.email),
///              ),
///            ),
///          ),
///
/// ```
class PUserBuilder extends ConsumerWidget {
  final String? uid;

  final Widget Function(BuildContext context, PUser user) builder;

  final Widget Function(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  )? errorBuilder;

  final Widget Function(BuildContext context)? loadingBuilder;

  const PUserBuilder.fromUid({
    Key? key,
    required this.uid,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
  }) : super(key: key);

  const PUserBuilder.fromCurrent({
    Key? key,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
  })  : uid = null,
        super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFuture = uid != null
        ? ref.watch(pUserProvider(uid!))
        : ref.watch(pCurrentUserProvider);
    return userFuture.when(
      data: (user) {
        if (user != null) {
          return builder.call(context, user);
        } else {
          if (uid == null) {
            ref.refresh(pCurrentUserProvider);
          }
        }
        return const SizedBox();
      },
      error: (_, __) => errorBuilder?.call(context, _, __) ?? const SizedBox(),
      loading: () => loadingBuilder?.call(context) ?? const SizedBox(),
    );
  }
}

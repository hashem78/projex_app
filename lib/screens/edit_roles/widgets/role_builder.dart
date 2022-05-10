import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/roles.dart';

class PRoleBuilder extends ConsumerWidget {
  final String pid;
  final String rid;

  final Widget Function(BuildContext context, PRole role) builder;
  final Widget Function(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  )? errorBuilder;

  final Widget Function(BuildContext context)? loadingBuilder;
  const PRoleBuilder({
    Key? key,
    required this.pid,
    required this.rid,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider(RoleProivderData(pid: pid, rid: rid)));
    return role.when(
      data: (role) {
        return builder.call(context, role);
      },
      error: (_, __) => errorBuilder?.call(context, _, __) ?? const SizedBox(),
      loading: () => loadingBuilder?.call(context) ?? const SizedBox(),
    );
  }
}

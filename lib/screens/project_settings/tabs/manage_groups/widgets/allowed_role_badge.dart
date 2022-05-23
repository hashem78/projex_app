import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/role_bage.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/roles.dart';

class GroupAllowedRoleBadge extends ConsumerWidget {
  const GroupAllowedRoleBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rid = ref.watch(selectedRoleProvider);
    final pid = ref.watch(selectedProjectProvider);
    final roleFuture = ref.watch(
      roleProvider(
        RoleProivderData(pid: pid, rid: rid),
      ),
    );
    return roleFuture.when(
      data: (role) => RoleBadge(role: role),
      error: (_, __) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}

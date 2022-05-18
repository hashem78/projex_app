import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:projex_app/models/role_model/role.dart';

import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class RoleCheckboxTile extends ConsumerWidget {
  const RoleCheckboxTile({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final user = ref.watch(userProvider);
    return CheckboxListTile(
      title: Text(role.name),
      value: project.userRoleMap[user.id]?.contains(role.id) ?? false,
      onChanged: (val) async {
        final project = ref.read(projectProvider);
        final user = ref.read(userProvider);
        if (project.userRoleMap[user.id]!.contains('owner')) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            const SnackBar(content: Text('Can\'t remove Owner role!')),
          );
          return;
        }
        if (!val!) {
          await project.removeRoleFromUser(
            userId: user.id,
            role: role,
          );
        } else {
          await project.assignRoleToUser(
            userId: user.id,
            role: role,
          );
        }
      },
    );
  }
}

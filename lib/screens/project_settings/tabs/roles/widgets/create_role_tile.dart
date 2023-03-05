import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/router_provider.dart';
import 'package:uuid/uuid.dart';

class CreateRoleTile extends ConsumerWidget {
  const CreateRoleTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.projectSettings;
    return ListTile(
      leading: const Icon(
        Icons.add,
        color: Colors.green,
      ),
      title: Text(translations.rolesTabCreateRoleButtonText),
      onTap: () async {
        final project = ref.read(projectProvider);
        final newRole = PRole(
          id: const Uuid().v4(),
          color: Colors.blue.value.toRadixString(16),
          name: 'New Role',
        );
        await project.createRole(newRole);
        ref
            .read(
              routerProvider,
            )
            .push(
              '/project/${project.id}/editRole?roleId=${newRole.id}',
              extra: project,
            );
      },
    );
  }
}

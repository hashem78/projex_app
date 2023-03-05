import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/widgets/delete_something_dialog.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/router_provider.dart';

class DeleteRoleTile extends ConsumerWidget {
  const DeleteRoleTile({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.editRolePage;

    return ListTile(
      leading: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onTap: () async {
        final shouldDelete = await showDialog<bool>(
              context: context,
              builder: (_) => DeleteSomethingDialog(name: role.name),
            ) ??
            false;
        if (shouldDelete) {
          ref.read(routerProvider).pop();
          final project = ref.read(projectProvider);
          await project.removeRole(role.id);
        }
      },
      title: Text(
        translations.manageTabDeleteRoleButtonText,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

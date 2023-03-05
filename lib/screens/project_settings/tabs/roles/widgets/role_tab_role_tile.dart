import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/widgets/delete_something_dialog.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSettingsRoleTabTile extends ConsumerWidget {
  const ProjectSettingsRoleTabTile({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return ListTile(
      tileColor: Color(int.parse(role.color, radix: 16)),
      onTap: () {
        final projectId = ref.watch(selectedProjectProvider);
        context.push(
          '/project/$projectId/editRole?roleId=${role.id}',
          extra: project,
        );
      },
      title: Text(
        role.name,
        style: const TextStyle(color: Colors.white),
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            role.count.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
      ),
      trailing: role.id != 'owner'
          ? IconButton(
              color: Colors.red,
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () async {
                final shouldDelete = await showDialog<bool>(
                      context: context,
                      builder: (_) => DeleteSomethingDialog(name: role.name),
                    ) ??
                    false;
                if (shouldDelete) {
                  final project = ref.read(projectProvider);
                  await project.removeRole(role.id);
                }
              },
            )
          : null,
    );
  }
}

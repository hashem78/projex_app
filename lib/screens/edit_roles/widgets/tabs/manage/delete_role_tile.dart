import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';

class DeleteRoleTile extends StatelessWidget {
  const DeleteRoleTile({
    Key? key,
    required this.role,
    required this.project,
  }) : super(key: key);

  final PRole role;
  final PProject project;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onTap: () async {
        final shouldDelete = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    'Are you sure you want to delete ${role.name}, this action is irreversable!',
                  ),
                  title: Text("Delete ${role.name}"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            ) ??
            false;
        if (shouldDelete) {
          context.pop();
          await project.removeRole(role.id);
        }
      },
      title: const Text(
        'Delete Role',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}

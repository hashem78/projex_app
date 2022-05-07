import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/editing.dart';
import 'package:uuid/uuid.dart';

class RolesTab extends ConsumerWidget {
  final PProject project;

  const RolesTab({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(allowEditingProjectProvider);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: isEditing
                    ? () {
                        context.push(
                          '/project/editRole?roleId=rid',
                          extra: {
                            'role': PRole(
                              id: const Uuid().v4(),
                              name: 'Instructor',
                              color: 'ff0000ff',
                            ),
                            'project': project,
                          },
                        );
                      }
                    : null,
                title: const Text('Admin'),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('1'),
                    Icon(Icons.person),
                  ],
                ),
                trailing: isEditing
                    ? IconButton(
                        color: Colors.red,
                        icon: const Icon(Icons.close),
                        onPressed: () {},
                      )
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

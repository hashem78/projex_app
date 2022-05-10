import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:uuid/uuid.dart';

class PProjectScreenFAB extends ConsumerWidget {
  final PProject project;
  const PProjectScreenFAB({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SpeedDial(
      icon: Icons.settings,
      children: [
        SpeedDialChild(
          backgroundColor: Colors.purple,
          onTap: () {
            context.push('/project/addMembers?pid=${project.id}');
          },
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        SpeedDialChild(
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.people,
            color: Colors.white,
          ),
          onTap: () async {
            final newRole = PRole(
              id: const Uuid().v4(),
              color: Colors.blue.value.toRadixString(16),
              name: 'New Role',
            );
            await project.createRole(newRole);
            context.push(
              '/project/editRole?roleId=${newRole.id}',
              extra: project,
            );
          },
        ),
      ],
    );
  }
}

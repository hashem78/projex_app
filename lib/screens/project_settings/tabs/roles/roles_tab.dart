import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/project_settings/tabs/roles/widgets/create_role_tile.dart';

import 'package:projex_app/state/project_provider.dart';

class RolesTab extends ConsumerWidget {
  const RolesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: CreateRoleTile(),
        ),
        FirestoreQueryBuilder<PRole>(
          query: FirebaseFirestore.instance
              .collection(
                'projects/${project.id}/roles',
              )
              .withConverter<PRole>(
                fromFirestore: (r, _) => PRole.fromJson(r.data()!),
                toFirestore: (r, _) => r.toJson(),
              ),
          builder: (context, snap, _) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: snap.docs.length,
                (context, index) {
                  final role = snap.docs[index].data();
                  return ProjectSettingsRoleTabTile(role: role);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

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
                await project.removeRole(role.id);
              },
            )
          : null,
    );
  }
}

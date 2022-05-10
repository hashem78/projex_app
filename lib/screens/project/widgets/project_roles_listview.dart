import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/editing.dart';
import 'package:projex_app/state/router_provider.dart';

class ProjectRolesListView extends ConsumerWidget {
  const ProjectRolesListView({
    Key? key,
    required this.project,
    this.showDelete = true,
  }) : super(key: key);

  final PProject project;

  final bool showDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(allowEditingProjectProvider);

    final router = ref.watch(routerProvider);
    return FirestoreListView<PRole>(
      query: FirebaseFirestore.instance
          .collection(
            'projects/${project.id}/roles',
          )
          .withConverter<PRole>(
            fromFirestore: (r, _) => PRole.fromJson(r.data()!),
            toFirestore: (r, _) => r.toJson(),
          ),
      itemBuilder: (context, snap) {
        final role = snap.data();
        return ListTile(
          tileColor: Color(int.parse(role.color, radix: 16)),
          onTap: isEditing && !router.location.contains(role.id)
              ? () {
                  context.push(
                    '/project/editRole?roleId=${role.id}',
                    extra: project,
                  );
                }
              : null,
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
          trailing: isEditing && showDelete
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
      },
    );
  }
}

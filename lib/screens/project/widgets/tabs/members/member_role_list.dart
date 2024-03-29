import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/edit_project_user_roles_button.dart';
import 'package:projex_app/screens/project/widgets/role_bage.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class MemberRoleList extends ConsumerWidget {
  final bool allowAddingRoles;
  const MemberRoleList({
    Key? key,
    this.allowAddingRoles = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final user = ref.watch(userProvider);
    if (project.userRoleMap.containsKey(user.id) && project.userRoleMap[user.id]!.isNotEmpty) {
      return FirestoreQueryBuilder<PRole>(
        query: FirebaseFirestore.instance
            .collection(
              'projects/${project.id}/roles',
            )
            .where(
              'id',
              whereIn: project.userRoleMap[user.id]?.toList(),
            )
            .withConverter<PRole>(
              fromFirestore: (r, _) => PRole.fromJson(r.data()!),
              toFirestore: (r, _) => r.toJson(),
            ),
        builder: (context, snap, _) {
          if (snap.hasData) {
            final roles = snap.docs;

            return Wrap(
              spacing: 2.0,
              runSpacing: 2.0,
              children: [
                ...roles.map(
                  (role) => RoleBadge(role: role.data()),
                ),
                EditProjectUserRolesButton(
                  allowEditing: allowAddingRoles,
                ),
              ],
            );
          }
          return EditProjectUserRolesButton(
            allowEditing: allowAddingRoles,
          );
        },
      );
    }
    return EditProjectUserRolesButton(
      allowEditing: allowAddingRoles,
    );
  }
}

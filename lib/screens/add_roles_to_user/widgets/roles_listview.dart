import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/add_roles_to_user/widgets/role_checkbox_tile.dart';

class RolesListView extends StatelessWidget {
  const RolesListView({
    Key? key,
    required this.project,
    required this.user,
  }) : super(key: key);

  final PProject project;
  final PUser user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreListView<PRole>(
        query: FirebaseFirestore.instance
            .collection(
              'project/${project.id}/roles',
            )
            .withConverter<PRole>(
              fromFirestore: (r, _) => PRole.fromJson(r.data()!),
              toFirestore: (r, _) => r.toJson(),
            ),
        itemBuilder: (context, snap) {
          final role = snap.data();
          return RoleCheckboxTile(
            role: role,
            project: project,
            user: user,
          );
        },
      ),
    );
  }
}

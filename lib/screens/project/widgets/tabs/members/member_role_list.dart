import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/edit_project_user_roles_button.dart';
import 'package:projex_app/screens/project/widgets/role_bage.dart';

class MemberRoleList extends StatelessWidget {
  const MemberRoleList({
    Key? key,
    required this.project,
    required this.user,
  }) : super(key: key);

  final PProject project;
  final PUser user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (project.userRoleMap.containsKey(user.id) && project.userRoleMap[user.id]!.isNotEmpty)
          FirestoreQueryBuilder<PRole>(
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
                if (roles.isNotEmpty) {
                  return SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: roles.length,
                      itemBuilder: (context, index) {
                        return RoleBadge(role: roles[index].data());
                      },
                    ),
                  );
                }
              }
              return const SizedBox();
            },
          ),
        EditProjectUserRolesButton(
          pid: project.id,
          uid: user.id,
        ),
      ],
    );
  }
}

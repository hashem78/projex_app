import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/home/widgets/puser_builder.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';

class RoleMembersListView extends ConsumerWidget {
  const RoleMembersListView({
    Key? key,
    required this.role,
  }) : super(key: key);

  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pid = ref.watch(selectedProjectProvider);
    return Expanded(
      child: FirestoreListView<String>(
        query: FirebaseFirestore.instance
            .collection(
              '/projects/$pid/roles/${role.id}/userIds',
            )
            .withConverter<String>(
              fromFirestore: (snap, _) => snap.data()!['id']!,
              toFirestore: (_, __) => {},
            ),
        itemBuilder: (context, uid) {
          return PUserBuilder.fromUid(
            uid: uid.data(),
            builder: (context, user) {
              return Row(
                children: [
                  Expanded(
                    child: ProjectMemberTile(
                      user: user,
                      showRoles: false,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final pid = ref.read(selectedProjectProvider);
                      final cu = ref.read(authProvider)!;
                      await cu.removeRoleFromUser(
                        projectId: pid,
                        userId: user.id,
                        role: role,
                      );
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

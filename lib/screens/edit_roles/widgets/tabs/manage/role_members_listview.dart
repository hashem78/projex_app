import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/manage/manage_tab_member_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

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
          return ProviderScope(
            overrides: [
              selectedUserProvider.overrideWithValue(uid.data()),
            ],
            child: ManageTabMemberTile(role: role),
          );
        },
      ),
    );
  }
}

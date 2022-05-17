import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/screens/add_roles_to_user/widgets/role_checkbox_tile.dart';
import 'package:projex_app/state/project_provider.dart';

class RolesListView extends ConsumerWidget {
  const RolesListView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final PUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(selectedProjectProvider);
    return Expanded(
      child: FirestoreListView<PRole>(
        query: FirebaseFirestore.instance
            .collection(
              'projects/$id/roles',
            )
            .withConverter<PRole>(
              fromFirestore: (r, _) => PRole.fromJson(r.data()!),
              toFirestore: (r, _) => r.toJson(),
            ),
        itemBuilder: (context, snap) {
          final role = snap.data();
          return RoleCheckboxTile(
            role: role,
            user: user,
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/edit_chat_group/widgets/edit_chat_role_list_tile.dart';
import 'package:projex_app/state/project_provider.dart';

class EditChatRoleList extends ConsumerWidget {
  const EditChatRoleList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pid = ref.read(selectedProjectProvider);

    return FirestoreQueryBuilder<PRole>(
      query: FirebaseFirestore.instance
          .collection(
            'projects/$pid/roles',
          )
          .withConverter(
            fromFirestore: (r, _) => PRole.fromJson(r.data()!),
            toFirestore: (_, __) => {},
          ),
      builder: (context, snap, _) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: snap.docs.length,
            (context, index) {
              final role = snap.docs[index].data();
              return EditChatRoleListTile(role: role);
            },
          ),
        );
      },
    );
  }
}

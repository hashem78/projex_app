import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/group_chat.dart';
import 'package:projex_app/state/project_provider.dart';

class EditChatGroupScreen extends ConsumerWidget {
  const EditChatGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectId = ref.watch(selectedProjectProvider);
    final project = ref.watch(projectProvider);
    final group = ref.watch(groupChatProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 0.25.sh,
            title: Text(project.name),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(group.name),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: TextFormField(
                initialValue: group.name,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Group name',
                  hintText: group.name,
                ),
                onChanged: (val) async {
                  final projectId = ref.read(selectedProjectProvider);
                  final groupId = ref.read(selectedGroupProvider);
                  final group = ref.read(groupChatProvider).copyWith(name: val);

                  await FirebaseFirestore.instance
                      .doc(
                        'projects/$projectId/groupChats/$groupId',
                      )
                      .update(
                        group.toJson(),
                      );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Roles that can access this group',
                style: TextStyle(fontSize: 50.sp),
              ),
            ),
          ),
          FirestoreQueryBuilder<PRole>(
            query: FirebaseFirestore.instance
                .collection(
                  'projects/$projectId/roles',
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
                    return CheckboxListTile(
                      value: group.allowedRoleIds.contains(role.id),
                      title: Text(role.name),
                      onChanged: (val) {
                        final notifier = ref.watch(groupChatProvider.notifier);
                        if (val!) {
                          notifier.addRole(role.id);
                        } else {
                          notifier.removeRole(role.id);
                        }
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

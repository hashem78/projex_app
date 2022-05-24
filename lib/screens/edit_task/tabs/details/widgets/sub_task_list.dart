import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/task_model/task_mode.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/sub_task_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/sub_task_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class SubTaskList extends ConsumerWidget {
  const SubTaskList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pid = ref.watch(selectedProjectProvider);
    final tid = ref.watch(selectedTaskProvider);
    return FirestoreQueryBuilder<PTask>(
      query: FirebaseFirestore.instance
          .collection(
            'projects/$pid/tasks/$tid/subTasks',
          )
          .withConverter<PTask>(
            fromFirestore: (t, _) => PTask.fromJson(t.data()!),
            toFirestore: (_, __) => {},
          ),
      builder: (context, snap, _) {
        final subtasks = snap.docs;
        if (subtasks.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('There are no subtasks'),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: subtasks.length,
            (context, index) {
              final subTask = subtasks[index].data();
              return ProviderScope(
                overrides: [
                  selectedTaskProvider.overrideWithValue(tid),
                  selectedSubTaskProvider.overrideWithValue(subTask.id),
                ],
                child: const SubTaskTile(),
              );
            },
          ),
        );
      },
    );
  }
}

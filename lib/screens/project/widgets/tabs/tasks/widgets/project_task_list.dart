import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/task_model/task_mode.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/widgets/project_task_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/task_provider.dart';

class ProjectTaskList extends ConsumerWidget {
  const ProjectTaskList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectId = ref.watch(selectedProjectProvider);
    return FirestoreQueryBuilder<PTask>(
      query: FirebaseFirestore.instance
          .collection(
            'projects/$projectId/tasks',
          )
          .withConverter<PTask>(
            fromFirestore: (t, _) => PTask.fromJson(t.data()!),
            toFirestore: (_, __) => {},
          ),
      builder: (context, snap, _) {
        final tasks = snap.docs;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: tasks.length,
            (context, index) {
              final task = tasks[index].data();
              return ProviderScope(
                overrides: [
                  selectedTaskProvider.overrideWithValue(task.id),
                ],
                child: const ProjectTaskTile(),
              );
            },
          ),
        );
      },
    );
  }
}

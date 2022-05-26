import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/task_model/task_model.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';

import 'package:projex_app/state/task_provider.dart';
import 'package:uuid/uuid.dart';

class CreateSubTaskTile extends ConsumerStatefulWidget {
  const CreateSubTaskTile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CreateSubTaskTile> createState() => _CreateSubTaskTileState();
}

class _CreateSubTaskTileState extends ConsumerState<CreateSubTaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final authedUser = ref.read(authProvider);
        final tid = ref.read(selectedTaskProvider);
        final pid = ref.read(selectedProjectProvider);
        final id = const Uuid().v4();
        final now = DateTime.now();
        final tomorrow = now.add(const Duration(days: 1));
        final task = PTask(
          title: 'A new sub task',
          description: 'This is a new sub task',
          creatorId: authedUser.id,
          id: id,
          startDate: now,
          endDate: tomorrow,
          dueDate: tomorrow,
        );

        final db = FirebaseFirestore.instance;
        await db.doc('projects/$pid/tasks/$tid/subTasks/$id').set(task.toJson());
        if (!mounted) return;
        context.push('/project/$pid/editTask/$tid/editSubTask/$id');
      },
      leading: const Icon(
        Icons.add,
        color: Colors.green,
      ),
      title: const Text('Add sub task'),
    );
  }
}

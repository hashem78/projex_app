import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/task_model/task_model.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:uuid/uuid.dart';

class ProjectScreenFAB extends ConsumerStatefulWidget {
  const ProjectScreenFAB({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ProjectScreenFAB> createState() => _ProjectScreenFABState();
}

class _ProjectScreenFABState extends ConsumerState<ProjectScreenFAB> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        onPressed: () async {
          final authedUser = ref.read(authProvider);
          final pid = ref.read(selectedProjectProvider);
          final id = const Uuid().v4();
          final now = DateTime.now();
          final tomorrow = now.add(const Duration(days: 1));
          final task = PTask(
            title: 'A new task',
            description: 'This is a new task',
            creatorId: authedUser.id,
            id: id,
            startDate: now,
            endDate: tomorrow,
            dueDate: tomorrow,
          );

          final db = FirebaseFirestore.instance;
          await db.doc('projects/$pid/tasks/$id').set(task.toJson());
          if (!mounted) return;
          context.push('/project/$pid/task/$id');
        },
        child: const Text('Create Task'),
      ),
    );
  }
}

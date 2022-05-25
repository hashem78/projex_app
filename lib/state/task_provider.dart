import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/task_model/task_model.dart';
import 'package:projex_app/state/project_provider.dart';

final selectedTaskProvider = Provider.autoDispose<String>(
  (ref) {
    throw UnimplementedError('selectedTaskProvider should be overriden');
  },
);

class TaskNotifier extends StateNotifier<PTask> {
  StreamSubscription? subscription;
  final String tid;
  final String pid;
  TaskNotifier(this.tid, this.pid)
      : super(PTask(
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 1)),
          dueDate: DateTime.now().add(const Duration(days: 1)),
        )) {
    final db = FirebaseFirestore.instance;
    subscription ??= db
        .doc(
          'projects/$pid/tasks/$tid',
        )
        .snapshots()
        .map(
      (event) {
        if (event.data() != null) {
          return PTask.fromJson(event.data()!);
        } else {
          return PTask(
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 1)),
            dueDate: DateTime.now().add(const Duration(days: 1)),
          );
        }
      },
    ).listen(
      (event) {
        state = event;
      },
    );
  }
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}

final taskProvider = StateNotifierProvider.autoDispose<TaskNotifier, PTask>(
  (ref) {
    final tid = ref.watch(selectedTaskProvider);
    final pid = ref.watch(selectedProjectProvider);
    return TaskNotifier(tid, pid);
  },
  dependencies: [
    selectedTaskProvider,
    selectedProjectProvider,
  ],
);

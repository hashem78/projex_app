import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/task/tabs/subtasks/widgets/create_sub_task_tile.dart';
import 'package:projex_app/screens/task/tabs/subtasks/widgets/sub_task_list.dart';

class TaskSubTasksTab extends ConsumerWidget {
  const TaskSubTasksTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CreateSubTaskTile(),
        ),
        SubTaskList(),
      ],
    );
  }
}

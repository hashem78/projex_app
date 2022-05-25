import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/widgets/project_task_list.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/widgets/project_progress_indicator.dart';
import 'package:projex_app/state/project_provider.dart';

class TasksTab extends ConsumerWidget {
  const TasksTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberOfTasks = ref.watch(
      projectProvider.select((value) => value.numberOfTasks),
    );
    print(numberOfTasks);
    if (numberOfTasks == 0) {
      return const Center(
        child: Text('There are no tasks in this project'),
      );
    }
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ProjectProgressIndicator(),
        ),
        ProjectTaskList(),
      ],
    );
  }
}

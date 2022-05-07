import 'package:flutter/material.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/tasks_percent_indicator.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/task_tile.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              const ProjectProgressIndicator(progress: 75),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.all(8),
                child: Text(
                  'Tasks',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          );
        }
        return const ProjectScreenTaskTile();
      },
    );
  }
}

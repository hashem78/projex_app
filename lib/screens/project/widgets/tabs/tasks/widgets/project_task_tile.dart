import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/widgets/face_pile.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/widgets/project_task_tile_actions.dart';
import 'package:projex_app/screens/project/widgets/tabs/tasks/widgets/project_task_tile_progress_indicator.dart';
import 'package:projex_app/state/task_provider.dart';

class ProjectTaskTile extends ConsumerWidget {
  const ProjectTaskTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ProjectTaskTileProgressIndicator(),
              32.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title),
                  Text(
                    task.status.name,
                    style: TextStyle(color: task.status.color),
                  ),
                ],
              ),
              const Spacer(),
              const ProjectTaskTileActions(),
            ],
          ),
          FacePile(
            faceSize: 70.r,
            leftOffset: 55,
          ),
        ],
      ),
    );
  }
}

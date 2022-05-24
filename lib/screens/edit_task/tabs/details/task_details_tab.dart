import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/create_sub_task_tile.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/created_by_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/sub_task_list.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_description_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_due_date_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_end_date_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_start_date.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_status_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_title_field.dart';
import 'package:projex_app/state/task_provider.dart';

class TaskDetailsTab extends ConsumerWidget {
  const TaskDetailsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const CreatedByField(),
              16.verticalSpace,
              const TaskTitleTextField(),
              16.verticalSpace,
              const TaskDescriptionTextField(),
              16.verticalSpace,
              const TaskStartDateField(),
              16.verticalSpace,
              const TaskEndDateField(),
              16.verticalSpace,
              const TaskDueDateField(),
              16.verticalSpace,
              const TaskStatusField(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sub tasks',
                  style: TextStyle(fontSize: 50.sp),
                ),
              ),
              const CreateSubTaskTile(),
            ],
          ),
        ),
        if (task.id.isNotEmpty) const SubTaskList(),
      ],
    );
  }
}

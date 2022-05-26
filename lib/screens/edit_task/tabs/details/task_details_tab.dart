import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/created_by_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_description_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_due_date_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_end_date_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_start_date.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_status_field.dart';
import 'package:projex_app/screens/edit_task/tabs/details/widgets/task_title_field.dart';

class TaskDetailsTab extends StatelessWidget {
  const TaskDetailsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ],
    );
  }
}

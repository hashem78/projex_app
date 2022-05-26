import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/screens/sub_task/tabs/details/widgets/sub_task_created_by_field.dart';
import 'package:projex_app/screens/sub_task/tabs/details/widgets/sub_task_description_field.dart';
import 'package:projex_app/screens/sub_task/tabs/details/widgets/sub_task_due_date.dart';
import 'package:projex_app/screens/sub_task/tabs/details/widgets/sub_task_end_date_field.dart';
import 'package:projex_app/screens/sub_task/tabs/details/widgets/sub_task_start_date.dart';
import 'package:projex_app/screens/sub_task/tabs/details/widgets/sub_task_status_field.dart';
import 'package:projex_app/screens/sub_task/tabs/details/widgets/sub_task_title_field.dart';

class SubTaskDetailsTab extends ConsumerWidget {
  const SubTaskDetailsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SubTaskCreatedByField(),
              16.verticalSpace,
              const SubTaskTitleTextField(),
              16.verticalSpace,
              const SubTaskDescriptionTextField(),
              16.verticalSpace,
              const SubTaskStartDateField(),
              16.verticalSpace,
              const SubTaskEndDateField(),
              16.verticalSpace,
              const SubTaskDueDateField(),
              16.verticalSpace,
              const SubTaskStatusField(),
            ],
          ),
        ),
      ],
    );
  }
}

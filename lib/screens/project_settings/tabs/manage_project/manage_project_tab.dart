import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_project/widgets/delete_project_tile.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_project/widgets/project_settings_description_field.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_project/widgets/project_settings_end_date_field.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_project/widgets/project_settings_name_field.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_project/widgets/project_settings_start_date_field.dart';

class ManageProjectTab extends ConsumerWidget {
  const ManageProjectTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const ProjectSettingsNameField(),
          16.verticalSpace,
          const ProjectSettingsDescriptionField(),
          16.verticalSpace,
          const ProjectSettingsStartDateField(),
          16.verticalSpace,
          const ProjectSettingsEndDateField(),
          16.verticalSpace,
          const DeleteProjectTile(),
        ],
      ),
    );
  }
}

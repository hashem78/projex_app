import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_groups/widgets/allowed_role_badge.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_groups/widgets/delete_group_button.dart';
import 'package:projex_app/state/group_chat.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/roles.dart';

class ProjectSettingsGroupTile extends ConsumerWidget {
  const ProjectSettingsGroupTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupChatProvider);
    return InkWell(
      onTap: () {
        final projectId = ref.read(selectedProjectProvider);
        final groupId = ref.read(selectedGroupProvider);
        context.push('/project/$projectId/editChatGroup/$groupId');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    group.name,
                    style: TextStyle(
                      fontSize: 45.sp,
                    ),
                  ),
                  const Spacer(),
                  const DeleteGroupButton(),
                ],
              ),
              if (group.allowedRoleIds.isEmpty) 40.verticalSpace,
              if (group.allowedRoleIds.isNotEmpty)
                Wrap(
                  spacing: 2.0,
                  runSpacing: 2.0,
                  children: group.allowedRoleIds.map(
                    (e) {
                      return ProviderScope(
                        overrides: [
                          selectedRoleProvider.overrideWithValue(e),
                        ],
                        child: const GroupAllowedRoleBadge(),
                      );
                    },
                  ).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

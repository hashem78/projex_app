import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project_settings/tabs/manage_groups/widgets/delete_group_button.dart';
import 'package:projex_app/state/group_chat.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectSettingsGroupTile extends ConsumerWidget {
  const ProjectSettingsGroupTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupChatProvider);
    return ListTile(
      onTap: () {
        final projectId = ref.read(selectedProjectProvider);
        final groupId = ref.read(selectedGroupProvider);
        context.push('/project/$projectId/editChatGroup/$groupId');
      },
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(group.memberCount.toString()),
          const Icon(Icons.person),
        ],
      ),
      title: Text(group.name),
      trailing: const DeleteGroupButton(),
    );
  }
}

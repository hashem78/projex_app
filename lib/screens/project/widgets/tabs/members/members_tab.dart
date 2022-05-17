import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/remove_member_from_project_button.dart';
import 'package:projex_app/state/editing.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class MembersTab extends ConsumerWidget {
  const MembersTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(editingProvider(EditReason.project));
    final project = ref.watch(projectProvider);

    return ListView.builder(
      itemBuilder: (context, index) {
        final uid = project.memberIds.toList()[index];

        if (isEditing) {
          return ProviderScope(
            overrides: [
              selectedUserProvider.overrideWithValue(uid),
            ],
            child: Row(
              children: [
                const Expanded(child: ProjectMemberTile()),
                if (!project.userRoleMap[uid]!.contains('owner')) const RemoveMemberFromProjectButton(),
              ],
            ),
          );
        } else {
          return ProviderScope(
            overrides: [
              selectedUserProvider.overrideWithValue(uid),
            ],
            child: const ProjectMemberTile(),
          );
        }
      },
      itemCount: project.memberIds.length,
    );
  }
}

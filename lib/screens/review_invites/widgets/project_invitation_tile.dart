import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class ProjectInvitationTile extends ConsumerWidget {
  const ProjectInvitationTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Expanded(
          child: ProjectMemberTile(
            showRoles: false,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.check),
          color: Colors.green,
          onPressed: () async {
            final project = ref.read(projectProvider);
            final authedUser = ref.read(authProvider);
            final user = ref.read(selectedUserProvider);
            await authedUser.addMemberToProject(projectId: project.id, memberId: user);
            await project.removeInvitation(user);
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          color: Colors.red,
          onPressed: () async {
            final project = ref.read(projectProvider);
            final user = ref.read(selectedUserProvider);
            await project.removeInvitation(user);
          },
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:projex_app/state/user_provider.dart';

class ProjectPendingInvitationTile extends ConsumerWidget {
  const ProjectPendingInvitationTile({
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
          onPressed: () async {
            final uid = ref.read(selectedUserProvider);
            final project = ref.read(projectProvider);
            await project.removeInvitation(uid);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

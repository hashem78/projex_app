import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/screens/home/widgets/puser_builder.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/project_member_tile.dart';
import 'package:projex_app/screens/project/widgets/tabs/members/remove_member_from_project_button.dart';
import 'package:projex_app/state/editing.dart';

class MembersTab extends ConsumerWidget {
  const MembersTab({
    Key? key,
    required this.project,
  }) : super(key: key);

  final PProject project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(editingProvider(EditReason.project));

    return ListView.builder(
      itemBuilder: (context, index) {
        return PUserBuilder.fromUid(
          uid: project.memberIds.toList()[index],
          builder: (context, outterUser) {
            final child = ProjectMemberTile(
              project: project,
              user: outterUser,
            );
            if (isEditing) {
              return Row(
                children: [
                  Expanded(child: child),
                  RemoveMemberFromProjectButton(
                    pid: project.id,
                    uid: outterUser.id,
                  ),
                ],
              );
            }
            return child;
          },
        );
      },
      itemCount: project.memberIds.length,
    );
  }
}

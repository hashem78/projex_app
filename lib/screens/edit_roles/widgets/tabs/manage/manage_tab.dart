import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/manage/delete_role_tile.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/manage/number_of_members.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/manage/role_members_listview.dart';

class ManageTab extends ConsumerWidget {
  const ManageTab({
    Key? key,
    required this.project,
    required this.role,
  }) : super(key: key);

  final PProject project;
  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        DeleteRoleTile(
          role: role,
          project: project,
        ),
        NumberOfMembersThatHaveRoleTile(
          role: role,
        ),
        RoleMembersListView(
          project: project,
          role: role,
        ),
      ],
    );
  }
}

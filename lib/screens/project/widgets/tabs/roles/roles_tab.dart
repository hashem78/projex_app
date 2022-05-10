import 'package:flutter/material.dart';

import 'package:projex_app/models/project_model/project_model.dart';

import 'package:projex_app/screens/project/widgets/project_roles_listview.dart';

class RolesTab extends StatelessWidget {
  final PProject project;

  const RolesTab({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProjectRolesListView(
      project: project,
    );
  }
}

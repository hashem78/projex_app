import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/display/checkable_color_badge.dart';

class ColorRows extends ConsumerWidget {
  const ColorRows({
    Key? key,
    required this.role,
    required this.project,
  }) : super(key: key);
  final PRole role;
  final PProject project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateColor = Color(
      int.parse(role.color, radix: 16),
    );
    return InputDecorator(
      decoration: const InputDecoration(
        label: Text("Role color"),
        border: InputBorder.none,
      ),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 9,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        children: Colors.primaries.map(
          (pcolor) {
            return GestureDetector(
              onTap: () async {
                await project.editRole(
                  role.copyWith(
                    color: pcolor.value.toRadixString(16),
                  ),
                );
              },
              child: CheckableColorBadge(
                color: pcolor,
                roleColor: stateColor,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

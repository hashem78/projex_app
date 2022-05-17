import 'package:flutter/material.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/display/checkable_color_badge.dart';

class ColorRows extends StatelessWidget {
  const ColorRows({
    Key? key,
    required this.role,
  }) : super(key: key);
  final PRole role;

  @override
  Widget build(BuildContext context) {
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
            return CheckableColorBadge(
              color: pcolor,
              roleColor: stateColor,
              role: role,
            );
          },
        ).toList(),
      ),
    );
  }
}

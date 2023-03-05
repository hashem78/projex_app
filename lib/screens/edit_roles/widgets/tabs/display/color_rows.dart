import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/screens/edit_roles/widgets/tabs/display/checkable_color_badge.dart';
import 'package:projex_app/state/locale.dart';

class ColorRows extends ConsumerWidget {
  const ColorRows({
    Key? key,
    required this.role,
  }) : super(key: key);
  final PRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations.editRolePage;
    final stateColor = Color(
      int.parse(role.color, radix: 16),
    );
    return InputDecorator(
      decoration: InputDecoration(
        label: Text(translations.displayTabColorFieldTitleText),
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

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/role_model/role.dart';
import 'package:projex_app/state/project_provider.dart';

class CheckableColorBadge extends StatelessWidget {
  const CheckableColorBadge({
    Key? key,
    required this.color,
    required this.roleColor,
    required this.role,
  }) : super(key: key);

  final Color color;
  final Color roleColor;
  final PRole role;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () async {
            final project = ref.read(projectProvider);
            await project.editRole(
              role.copyWith(
                color: color.value.toRadixString(16),
              ),
            );
          },
          child: child,
        );
      },
      child: SizedBox(
        width: 35,
        height: 35,
        child: badge.Badge(
          badgeStyle: badge.BadgeStyle(
            shape: badge.BadgeShape.square,
            borderRadius: BorderRadius.circular(4.0),
            badgeColor: color,
          ),
          badgeContent: color.value == roleColor.value
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}

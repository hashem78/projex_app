import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:projex_app/models/role_model/role.dart';

class RoleBadge extends StatelessWidget {
  const RoleBadge({
    Key? key,
    required this.role,
    this.onTap,
    this.padding = const EdgeInsets.all(5.0),
  }) : super(key: key);
  final PRole role;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: badge.Badge(
        badgeStyle: badge.BadgeStyle(
          shape: badge.BadgeShape.square,
          borderRadius: BorderRadius.circular(8.0),
          badgeColor: Color(int.parse(role.color, radix: 16)),
          padding: padding,
        ),
        badgeContent: Text(
          role.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

import 'package:badges/badges.dart';
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
      child: Badge(
        padding: padding,
        shape: BadgeShape.square,
        badgeColor: Color(int.parse(role.color, radix: 16)),
        borderRadius: BorderRadius.circular(8),
        badgeContent: Text(
          role.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class CheckableColorBadge extends StatelessWidget {
  const CheckableColorBadge({
    Key? key,
    required this.color,
    required this.roleColor,
  }) : super(key: key);

  final Color color;
  final Color roleColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: Badge(
        toAnimate: false,
        badgeColor: color,
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(4.0),
        badgeContent: color.value == roleColor.value
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

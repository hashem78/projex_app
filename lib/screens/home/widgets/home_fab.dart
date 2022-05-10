import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';

class HomeFAB extends StatelessWidget {
  const HomeFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.create,
      activeIcon: Icons.close,
      children: [
        SpeedDialChild(
          backgroundColor: Colors.blue,
          onTap: () {
            context.push('/createProject');
          },
          child: const Icon(
            Icons.checklist,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/project_model/project_model.dart';

class PProjectScreenFAB extends ConsumerWidget {
  final PProject project;
  const PProjectScreenFAB({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SpeedDial(
      icon: Icons.settings,
      children: [
        SpeedDialChild(
          backgroundColor: Colors.purple,
          onTap: () {
            context.push('/project/addMembers?pid=${project.id}');
          },
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        SpeedDialChild(
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

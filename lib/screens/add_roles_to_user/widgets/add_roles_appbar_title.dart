import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/project_provider.dart';

class AddRolesAppBarTitle extends ConsumerWidget {
  const AddRolesAppBarTitle({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final String userName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectName = ref.watch(projectProvider.select((value) => value.name));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          projectName,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        Text(
          userName,
          style: const TextStyle(color: Colors.white, fontSize: 14.0),
        )
      ],
    );
  }
}

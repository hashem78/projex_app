import 'package:flutter/material.dart';
import 'package:projex_app/screens/profile/widgets/puser_builder.dart';

class RemoveMemberFromProjectButton extends StatelessWidget {
  const RemoveMemberFromProjectButton({
    Key? key,
    required this.pid,
    required this.uid,
  }) : super(key: key);

  final String pid;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return PUserBuilder.fromCurrent(
      builder: (context, innerUser) {
        return IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () async {
            await innerUser.removeMembersFromProject(
              projectId: pid,
              memberIds: [uid],
            );
          },
        );
      },
    );
  }
}

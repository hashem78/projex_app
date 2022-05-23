import 'package:flutter/material.dart';

class DeleteGroupDialog extends StatelessWidget {
  const DeleteGroupDialog({
    Key? key,
    required this.groupName,
  }) : super(key: key);
  final String groupName;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Group Chat'),
      content: Text('Are you sure you want to delete $groupName?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}

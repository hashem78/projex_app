import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/widgets/delete_something_dialog.dart';
import 'package:projex_app/state/group_chat.dart';
import 'package:projex_app/state/project_provider.dart';

class DeleteGroupButton extends ConsumerWidget {
  const DeleteGroupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        final groupName = ref.read(groupChatProvider).name;
        final db = FirebaseFirestore.instance;
        final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (context) => DeleteSomethingDialog(name: groupName),
        );
        if (shouldDelete != null && shouldDelete) {
          final projectId = ref.read(selectedProjectProvider);
          final groupId = ref.read(selectedGroupProvider);
          await db.doc('projects/$projectId/groupChats/$groupId').delete();
        }
      },
      icon: const Icon(
        Icons.close,
        color: Colors.red,
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/chat_group/chat_group_model.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:uuid/uuid.dart';

class CreateGroupTile extends ConsumerStatefulWidget {
  const CreateGroupTile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CreateGroupTile> createState() => _CreateGroupTileState();
}

class _CreateGroupTileState extends ConsumerState<CreateGroupTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.add),
      title: const Text('Create Group'),
      onTap: () async {
        final projectId = ref.read(selectedProjectProvider);
        final uuid = const Uuid().v4();
        final group = ChatGroup(id: uuid, name: 'New Group Chat');
        await FirebaseFirestore.instance
            .doc(
          'projects/$projectId/groupChats/$uuid',
        )
            .set(
          {
            ...group.toJson(),
            'tokens': <String>[],
          },
        );
        if (!mounted) return;
        context.push('/project/$projectId/editChatGroup/$uuid');
      },
    );
  }
}

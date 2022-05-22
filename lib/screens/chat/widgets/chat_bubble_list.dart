import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projex_app/models/message_model/message_model.dart';
import 'package:projex_app/screens/chat/widgets/chat_bubble.dart';
import 'package:projex_app/state/project_provider.dart';

class ChatBubbleList extends ConsumerWidget {
  const ChatBubbleList({
    Key? key,
    required this.chatId,
    this.showSenders = false,
    required this.isForGroup,
  }) : super(key: key);

  final String chatId;
  final bool showSenders;
  final bool isForGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectId = ref.watch(selectedProjectProvider);
    late final String path;
    if (isForGroup) {
      path = 'projects/$projectId/groupChats/$chatId/messages';
    } else {
      path = 'projects/$projectId/chats/$chatId/messages';
    }

    return FirestoreListView<PMessage>(
      reverse: true,
      query: FirebaseFirestore.instance
          .collection(path)
          .orderBy(
            'createdOn',
            descending: true,
          )
          .withConverter(
            fromFirestore: (m, _) => PMessage.fromJson(m.data()!),
            toFirestore: (_, __) => {},
          ),
      itemBuilder: (context, snap) {
        final message = snap.data();

        return PChatBubble(
          message: message,
          showSender: showSenders,
        );
      },
    );
  }
}

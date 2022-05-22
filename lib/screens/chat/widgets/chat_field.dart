import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/message_model/message_model.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';
import 'package:uuid/uuid.dart';

class ChatField extends ConsumerStatefulWidget {
  const ChatField({
    Key? key,
    required this.chatId,
    required this.isForGroup,
  }) : super(key: key);

  final String chatId;
  final bool isForGroup;

  @override
  ConsumerState<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends ConsumerState<ChatField> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final projectId = ref.read(selectedProjectProvider);
                final senderId = ref.read(authProvider).id;
                final message = PMessage(
                  id: const Uuid().v4(),
                  text: controller.text,
                  createdOn: DateTime.now(),
                  senderId: senderId,
                  senderToken: (await FirebaseMessaging.instance.getToken())!,
                );
                final db = FirebaseFirestore.instance;
                late final String path;
                if (!widget.isForGroup) {
                  path = 'projects/$projectId/chats/${widget.chatId}/messages/${message.id}';
                } else {
                  path = 'projects/$projectId/groupChats/${widget.chatId}/messages/${message.id}';
                }
                await db.doc(path).set(message.toJson());
                controller.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: const Center(
              child: Icon(
                Icons.send,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

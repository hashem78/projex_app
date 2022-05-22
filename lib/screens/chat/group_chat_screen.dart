import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/chat/widgets/chat_bubble_list.dart';
import 'package:projex_app/screens/chat/widgets/chat_field.dart';
import 'package:projex_app/state/group_chat.dart';

class GroupChatScreen extends ConsumerWidget {
  const GroupChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatId = ref.watch(selectedGroupProvider);
    final group = ref.watch(groupChatProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text(group.name)),
        body: Column(
          children: [
            Expanded(
              child: ChatBubbleList(
                chatId: chatId,
                showSenders: true,
                isForGroup: true,
              ),
            ),
            8.verticalSpace,
            ChatField(
              chatId: chatId,
              isForGroup: true,
            ),
          ],
        ),
      ),
    );
  }
}

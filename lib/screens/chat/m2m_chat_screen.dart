import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/chat/widgets/chat_bubble_list.dart';
import 'package:projex_app/screens/chat/widgets/chat_field.dart';

import 'package:projex_app/state/auth.dart';

import 'package:projex_app/state/user_provider.dart';

class M2MChatScreen extends ConsumerWidget {
  const M2MChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otherUser = ref.watch(userProvider);
    final authedUser = ref.watch(authProvider);
    final chatId = generateChatId(authedUser.id, otherUser.id);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text(otherUser.name)),
        body: Column(
          children: [
            Expanded(
              child: ChatBubbleList(
                chatId: chatId,
              ),
            ),
            8.verticalSpace,
            ChatField(
              chatId: chatId,
              isForGroup: false,
            ),
          ],
        ),
      ),
    );
  }
}

String generateChatId(String currentID, String otherId) {
  if (currentID.compareTo(otherId) > 0) {
    return otherId + currentID;
  } else {
    return currentID + otherId;
  }
}

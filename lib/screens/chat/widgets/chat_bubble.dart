import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:projex_app/models/message_model/message_model.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/theme_mode.dart';
import 'package:projex_app/state/user_provider.dart';

class PChatBubble extends ConsumerWidget {
  const PChatBubble({
    Key? key,
    required this.message,
    this.showSender = false,
  }) : super(key: key);

  final PMessage message;
  final bool showSender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authedUser = ref.watch(authProvider);
    final px = 1 / MediaQuery.of(context).devicePixelRatio;
    final formatter = DateFormat.jm();
    final textColor = ref.watch(themeModeProvider).flutterThemeMode == ThemeMode.dark ? Colors.black : null;

    return Bubble(
      margin: const BubbleEdges.only(top: 10),
      elevation: 0.5 * px,
      alignment: message.senderId == authedUser.id ? Alignment.topRight : Alignment.topLeft,
      nip: message.senderId == authedUser.id ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: const Color.fromARGB(255, 225, 255, 199),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (showSender)
            ProviderScope(
              overrides: [
                selectedUserProvider.overrideWithValue(message.senderId),
              ],
              child: Consumer(
                builder: (context, ref, _) {
                  return Text(
                    ref.watch(userProvider).name,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SelectableText(
                message.messageText,
                style: TextStyle(
                  color: textColor,
                ),
              ),
              8.horizontalSpace,
              Text(
                formatter.format(message.createdOn),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30.sp,
                ),
                textAlign: TextAlign.end,
              )
            ],
          ),
        ],
      ),
    );
  }
}

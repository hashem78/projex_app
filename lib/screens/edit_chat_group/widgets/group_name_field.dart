import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/state/group_chat.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/project_provider.dart';

class GroupNameField extends HookConsumerWidget {
  const GroupNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupName = ref.watch(groupChatProvider.select((value) => value.name));
    final gid = ref.watch(projectProvider.select((value) => value.id));
    final translations = ref.watch(translationProvider).translations.editGroupChatPage;

    final errorText = useValueNotifier<String?>(null);
    return TextFormField(
      key: ValueKey(gid),
      initialValue: groupName,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: translations.groupNameFieldTitleText,
        hintText: groupName,
        errorText: useValueListenable(errorText),
      ),
      onChanged: (val) async {
        if (val.length < 5) {
          errorText.value = 'A groups name has to be atleast 5 characters long';
          return;
        }
        errorText.value = null;
        final projectId = ref.read(selectedProjectProvider);
        final groupId = ref.read(selectedGroupProvider);
        final group = ref.read(groupChatProvider).copyWith(name: val);

        await FirebaseFirestore.instance
            .doc(
              'projects/$projectId/groupChats/$groupId',
            )
            .update(
              group.toJson(),
            );
      },
    );
  }
}

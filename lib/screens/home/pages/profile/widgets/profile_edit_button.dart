import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/editing.dart';

class ProfileEditButton extends ConsumerWidget {
  const ProfileEditButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(editingProvider(EditReason.profile));
    return IconButton(
      onPressed: () {
        final editing = ref.read(editingProvider(EditReason.profile));
        if (editing) {}
        ref.read(editingProvider(EditReason.profile).notifier).toggle();
      },
      icon: !isEditing ? const Icon(Icons.edit) : const Icon(Icons.done),
    );
  }
}

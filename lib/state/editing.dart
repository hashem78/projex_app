import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditingNotifier extends StateNotifier<bool> {
  EditingNotifier() : super(false);

  void set(bool s) {
    state = s;
  }

  void toggle() {
    state = !state;
  }
}

final allowEditingProjectProvider = StateNotifierProvider.autoDispose<EditingNotifier, bool>((ref) {
  return EditingNotifier();
});

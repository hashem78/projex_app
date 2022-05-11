import 'package:flutter_riverpod/flutter_riverpod.dart';

enum EditReason {
  profile,
  project,
}

class EditingNotifier extends StateNotifier<bool> {
  EditingNotifier() : super(false);

  void set(bool s) {
    state = s;
  }

  void toggle() {
    state = !state;
  }
}

final editingProvider = StateNotifierProvider.autoDispose.family<EditingNotifier, bool, EditReason>(
  (ref, reason) {
    return EditingNotifier();
  },
);

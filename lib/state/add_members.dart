import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/user_model/user_model.dart';

class MemberAddNotifier extends StateNotifier<Set<PUser>> {
  MemberAddNotifier() : super({});
  void add(PUser user) {
    state = {...state, user};
  }

  void remove(PUser user) {
    final stcpy = {...state};
    stcpy.remove(user);
    state = stcpy;
  }
}

final memberEmailsProvider = StateNotifierProvider.autoDispose<MemberAddNotifier, Set<PUser>>(
  (ref) {
    return MemberAddNotifier();
  },
);

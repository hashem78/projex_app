import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/role_model/role.dart';

class RoleProivderData {
  String pid;
  String rid;
  RoleProivderData({
    required this.pid,
    required this.rid,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoleProivderData && other.pid == pid && other.rid == rid;
  }

  @override
  int get hashCode => pid.hashCode ^ rid.hashCode;
}

final roleProvider = StreamProvider.autoDispose.family<PRole, RoleProivderData>(
  (ref, data) async* {
    final db = FirebaseFirestore.instance;
    yield* db
        .doc(
          'projects/${data.pid}/roles/${data.rid}',
        )
        .snapshots()
        .map(
          (event) => PRole.fromJson(event.data()!),
        );
  },
);

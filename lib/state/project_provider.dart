import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/project_model/project_model.dart';

final projectProvider = StreamProvider.family.autoDispose<PProject, String>(
  (ref, pid) async* {
    final db = FirebaseFirestore.instance;
    yield* db.doc('/projects/$pid').snapshots().map(
      (event) {
        return PProject.fromJson(event.data()!);
      },
    );
  },
);

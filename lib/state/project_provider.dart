import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/project_model/project_model.dart';

final selectedProjectProvider = Provider.autoDispose<String>(
  (_) {
    throw UnimplementedError("Make sure the project id is provided");
  },
);

class ProjectNotifier extends StateNotifier<PProject> {
  final String pid;
  StreamSubscription? subscription;
  ProjectNotifier(this.pid) : super(const PProject()) {
    final db = FirebaseFirestore.instance;
    subscription = db
        .doc(
          '/projects/$pid',
        )
        .snapshots()
        .map(
          (event) => event.data() != null ? PProject.fromJson(event.data()!) : const PProject(),
        )
        .listen((event) => state = event);
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}

final projectProvider = StateNotifierProvider.autoDispose<ProjectNotifier, PProject>(
  (ref) {
    final id = ref.watch(selectedProjectProvider);
    return ProjectNotifier(id);
  },
  dependencies: [selectedProjectProvider],
);

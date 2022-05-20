import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/chat_group/chat_group_model.dart';
import 'package:projex_app/state/project_provider.dart';

final userGroupChatsProvider = FutureProvider.autoDispose<List<ChatGroup>>(
  (ref) async {
    final fc = FirebaseFunctions.instance;
    final pid = ref.watch(selectedProjectProvider);

    final res = await fc.httpsCallable('getAllowedGroupsForUser').call(
      <String, dynamic>{
        'projectId': pid,
      },
    );
    final jsonGroups = res.data as List;
    final groups = <ChatGroup>[];
    for (final jsonGroup in jsonGroups) {
      groups.add(ChatGroup.fromJson(Map<String, dynamic>.from(jsonGroup)));
    }
    return groups;
  },
  dependencies: [selectedProjectProvider],
);

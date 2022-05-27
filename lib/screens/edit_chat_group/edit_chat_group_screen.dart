import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projex_app/screens/edit_chat_group/widgets/edit_chat_role_list.dart';
import 'package:projex_app/screens/edit_chat_group/widgets/group_name_field.dart';
import 'package:projex_app/state/group_chat.dart';
import 'package:projex_app/state/project_provider.dart';

class EditChatGroupScreen extends ConsumerWidget {
  const EditChatGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final group = ref.watch(groupChatProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 0.25.sh,
            title: Text(project.name),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(group.name),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: GroupNameField(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Roles that can access this group',
                style: TextStyle(fontSize: 50.sp),
              ),
            ),
          ),
          const EditChatRoleList(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/invite_members/widgets/invite_member_text_field.dart';
import 'package:projex_app/screens/invite_members/widgets/invite_members_button.dart';
import 'package:projex_app/screens/invite_members/widgets/invite_members_title.dart';
import 'package:projex_app/screens/invite_members/widgets/members_to_be_invited_list.dart';
import 'package:projex_app/state/project_provider.dart';

final inviteMembersKey = GlobalKey<FormBuilderState>();

class InviteMembersScreen extends StatelessWidget {
  const InviteMembersScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: FormBuilder(
          key: inviteMembersKey,
          child: const CustomScrollView(
            slivers: [
              InviteMembersAppBar(),
              InviteMembersEmailField(),
              MembersToBeInvitedList(),
              InviteMembersButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class InviteMembersAppBar extends ConsumerWidget {
  const InviteMembersAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return SliverAppBar(
      expandedHeight: 0.25.sh,
      title: Text(project.name),
      flexibleSpace: const FlexibleSpaceBar(
        title: InviteMembersScreenTitle(),
      ),
    );
  }
}

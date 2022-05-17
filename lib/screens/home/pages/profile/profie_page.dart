import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/join_project_dialoag.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_card.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_page_appbar.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';

class HomeProfilePage extends ConsumerWidget {
  const HomeProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return CustomScrollView(
      slivers: [
        const ProfileScreenAppBar(),
        SliverPadding(
          padding: EdgeInsets.only(top: 0.065.sh, left: 12, right: 12),
          sliver: const ProfileCard(),
        ),
        SliverToBoxAdapter(
          child: ListTile(
            leading: const Icon(
              Icons.add,
              color: Colors.green,
            ),
            title: const Text('Create Project'),
            contentPadding: const EdgeInsetsDirectional.only(start: 20.0),
            onTap: () {
              context.push('/createProject');
            },
          ),
        ),
        SliverToBoxAdapter(
          child: ListTile(
            leading: const Icon(
              Icons.door_back_door,
              color: Colors.blue,
            ),
            title: const Text('Join Project'),
            contentPadding: const EdgeInsetsDirectional.only(start: 20.0),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => const JoinProjectDialog(),
              );
            },
          ),
        ),
        if (user.invites.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(12.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Invitations',
                style: TextStyle(fontSize: 50.sp),
              ),
            ),
          ),
        if (user.invites.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: user.invites.length,
              (context, index) {
                final invite = user.invites.toList()[index];
                return ProviderScope(
                  overrides: [selectedProjectProvider.overrideWithValue(invite)],
                  child: const ProfilePageProjectInviteTile(),
                );
              },
            ),
          ),
      ],
    );
  }
}

// TODO: distinguish between invitations and join requsts.
class ProfilePageProjectInviteTile extends ConsumerWidget {
  const ProfilePageProjectInviteTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Center(
              child: Text(
                project.name.isNotEmpty ? project.name[0] : "",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: Text(
              project.name,
              style: TextStyle(
                fontSize: 50.sp,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              final user = ref.read(authProvider);
              await project.removeInvitation(user.id);
              await user.addMemberToProject(projectId: project.id, memberId: user.id);
            },
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () async {
              final user = ref.read(authProvider);
              await project.removeInvitation(user.id);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

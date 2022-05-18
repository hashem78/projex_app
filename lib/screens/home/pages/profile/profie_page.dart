import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/join_project_dialoag.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_card.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_page_appbar.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_project_invitation_tile.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_project_join_request_tile.dart';
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
        if (user.invitations.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(12.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Invitations',
                style: TextStyle(fontSize: 50.sp),
              ),
            ),
          ),
        if (user.invitations.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: user.invitations.length,
              (context, index) {
                final invite = user.invitations.toList()[index];
                return ProviderScope(
                  overrides: [selectedProjectProvider.overrideWithValue(invite)],
                  child: const ProfilePageProjectInvitationTile(),
                );
              },
            ),
          ),
        if (user.joinRequests.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(12.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Pending Requests',
                style: TextStyle(fontSize: 50.sp),
              ),
            ),
          ),
        if (user.joinRequests.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: user.joinRequests.length,
              (context, index) {
                final joinRequest = user.joinRequests.toList()[index];
                return ProviderScope(
                  overrides: [selectedProjectProvider.overrideWithValue(joinRequest)],
                  child: const ProfilePageProjectJoinRequestTile(),
                );
              },
            ),
          ),
      ],
    );
  }
}

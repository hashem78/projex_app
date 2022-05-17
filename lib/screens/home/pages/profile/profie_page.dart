import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/join_project_dialoag.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_card.dart';
import 'package:projex_app/screens/home/pages/profile/widgets/profile_page_appbar.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}

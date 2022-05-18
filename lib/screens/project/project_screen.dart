import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project/widgets/project_screen_fab.dart';
import 'package:projex_app/screens/project/widgets/project_sliverappbar.dart';
import 'package:projex_app/screens/project/widgets/project_tabbar_view.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);

    ref.listen<Set<String>>(
      projectProvider.select((value) => value.memberIds),
      (previous, next) {
        final authedUser = ref.read(authProvider);
        if (!next.contains(authedUser.id)) {
          context.pop();
        }
      },
    );
    return Scaffold(
      floatingActionButton: PProjectScreenFAB(project: project),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            ProjectSliverAppbar(context: context),
            if (project.joinRequests.isNotEmpty)
              SliverToBoxAdapter(
                child: MaterialBanner(
                  backgroundColor: Colors.green,
                  leading: const Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  contentTextStyle: const TextStyle(color: Colors.white),
                  content: const Text('There are join requests pending'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.push('/project/${project.id}/reviewJoinRequests');
                      },
                      child: const Text(
                        'Review',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
          ],
          body: const ProjectTabBarView(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/project_screen_fab.dart';
import 'package:projex_app/screens/project/widgets/project_sliverappbar.dart';
import 'package:projex_app/screens/project/widgets/project_tabbar_view.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    return Scaffold(
      floatingActionButton: PProjectScreenFAB(project: project),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            ProjectSliverAppbar(context: context),
          ],
          body: const ProjectTabBarView(),
        ),
      ),
    );
  }
}
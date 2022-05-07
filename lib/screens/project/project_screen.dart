import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/project/widgets/project_builder.dart';
import 'package:projex_app/screens/project/widgets/project_screen_fab.dart';
import 'package:projex_app/screens/project/widgets/project_sliverappbar.dart';
import 'package:projex_app/screens/project/widgets/project_tabbar_view.dart';

class ProjectScreen extends ConsumerWidget {
  final String id;
  const ProjectScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PProjectBuilder(
      pid: id,
      builder: (context, project) {
        return Scaffold(
          floatingActionButton: PProjectScreenFAB(project: project),
          body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, _) => [
                ProjectSliverAppbar(
                  context: context,
                  projectName: project.name,
                )
              ],
              body: ProjectTabBarView(project: project),
            ),
          ),
        );
      },
    );
  }
}

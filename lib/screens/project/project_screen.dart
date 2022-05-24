import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project/widgets/project_screen_fab.dart';
import 'package:projex_app/screens/project/widgets/project_sliverappbar.dart';
import 'package:projex_app/screens/project/widgets/project_tabbar_view.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/project_provider.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> with TickerProviderStateMixin {
  late final TabController tabController;
  bool showFab = true;
  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );

    tabController.addListener(
      () {
        if (tabController.index == 0) {
          setState(() {
            showFab = true;
          });
        } else {
          setState(() {
            showFab = false;
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: showFab ? const ProjectScreenFAB() : null,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [
          ProjectSliverAppbar(
            context: context,
            tabController: tabController,
          ),
        ],
        body: ProjectTabBarView(
          tabController: tabController,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

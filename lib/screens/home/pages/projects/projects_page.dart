import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/project/widgets/project_builder.dart';
import 'package:projex_app/state/auth.dart';

class HomeProjectsPage extends ConsumerWidget {
  const HomeProjectsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider)!;
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final pid = user.projectIds[index];
              return PProjectBuilder(
                pid: pid,
                builder: (context, project) {
                  return ListTile(
                    title: Text(project.name),
                    onTap: () {
                      context.push('/project/${project.id}');
                    },
                  );
                },
              );
            },
            childCount: user.projectIds.length,
          ),
        ),
      ],
    );
  }
}

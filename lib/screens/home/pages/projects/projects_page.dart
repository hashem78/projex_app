import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/state/user_provider.dart';

class HomeProjectsPage extends StatelessWidget {
  const HomeProjectsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 0.25.sh,
          backgroundColor: Colors.green,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Explore Projects'),
          ),
        ),
        FirestoreQueryBuilder<PProject>(
          query: FirebaseFirestore.instance
              .collection(
                '/projects',
              )
              .where('public', isEqualTo: true)
              .withConverter(
                fromFirestore: (p, _) => PProject.fromJson(p.data()!),
                toFirestore: (_, __) => {},
              ),
          builder: (context, snapshot, child) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: snapshot.docs.length,
                (context, index) {
                  final project = snapshot.docs[index].data();

                  return ProviderScope(
                    overrides: [
                      selectedUserProvider.overrideWithValue(project.creatorId),
                    ],
                    child: ProjectPageTile(
                      project: project,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class ProjectPageTile extends ConsumerWidget {
  const ProjectPageTile({
    Key? key,
    required this.project,
  }) : super(key: key);

  final PProject project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creator = ref.watch(userProvider);
    return ListTile(
      leading: CircleAvatar(
        child: Center(
          child: Text(project.name[0]),
        ),
      ),
      title: Text(project.name),
      subtitle: Text(creator.name),
      onTap: () {
        context.push('/project/${project.id}');
      },
    );
  }
}
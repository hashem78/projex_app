import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/project_model/project_model.dart';

class HomeProjectsPage extends StatelessWidget {
  const HomeProjectsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        FirestoreQueryBuilder<PProject>(
          query: FirebaseFirestore.instance
              .collection(
                '/projects',
              )
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

                  return ListTile(
                    title: Text(project.name),
                    onTap: () {
                      context.push('/project/${project.id}');
                    },
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/project_model/project_model.dart';
import 'package:projex_app/screens/home/widgets/drawer.dart';
import 'package:projex_app/state/locale.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.home.appBarTitle),
      ),
      drawer: const PDrawer(),
      body: FirestoreListView<PProject>(
        query: FirebaseFirestore.instance
            .collection(
              'projects',
            )
            .withConverter(
              fromFirestore: (snapshot, _) {
                return PProject.fromJson(
                  snapshot.data()!,
                );
              },
              toFirestore: (u, _) => u.toJson(),
            ),
        itemBuilder: (context, snapshot) {
          final data = snapshot.data();
          return ListTile(
            onTap: () {
              context.push('/project?pid=${data.id}');
            },
            title: Text(data.name),
          );
        },
      ),
    );
  }
}

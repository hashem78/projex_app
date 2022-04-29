import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/state/auth.dart';

class FirstTimeSignInScreen extends ConsumerWidget {
  const FirstTimeSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'I am',
                style: Theme.of(context).textTheme.headline1,
              ),
              ListTile(
                title: Text(
                  'An instructor',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
                onTap: () async {
                  final auth = FirebaseAuth.instance;
                  final db = FirebaseFirestore.instance;
                  final user = auth.currentUser;
                  final userDoc = db.doc('users/${user!.uid}');
                  await userDoc.set(
                    PUser.instructor(
                      id: user.uid,
                      name: user.displayName ?? "Anon",
                      email: user.email ?? "Anon@email",
                      profilePicture: PProfilePicture(
                        link: user.photoURL ?? "",
                      ),
                    ).toJson(),
                  );
                  ref.read(authProvider).isFirstTime = false;
                  context.go('/');
                },
              ),
              ListTile(
                title: Text(
                  'A student',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
                onTap: () async {
                  final auth = FirebaseAuth.instance;
                  final db = FirebaseFirestore.instance;
                  final user = auth.currentUser;
                  final userDoc = db.doc('users/${user!.uid}');
                  await userDoc.set(
                    PUser.student(
                      id: user.uid,
                      studentNumber: "",
                      name: user.displayName ?? "Anon",
                      email: user.email ?? "Anon@email",
                      profilePicture: PProfilePicture(
                        link: user.photoURL ?? "",
                      ),
                    ).toJson(),
                  );
                  ref.read(authProvider).isFirstTime = false;
                  context.go('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

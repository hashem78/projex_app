import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/enums/registration_type.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/models/user_model/user_model.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/locale.dart';

class InstructorSelectionTile extends ConsumerWidget {
  const InstructorSelectionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations;
    return ListTile(
      title: Text(
        translations.login.firstTimeInstructor,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
      onTap: () async {
        final auth = FirebaseAuth.instance;
        final db = FirebaseFirestore.instance;
        final user = auth.currentUser;
        if (user?.photoURL == null && user?.displayName == null) {
          final userDoc = db.doc('users/${user!.uid}');
          await userDoc.set(
            PUser.instructor(
              id: user.uid,
              email: user.email ?? "Anon@email",
            ).toJson(),
          );
          context.go(
            '/firstTime/continueRegistration',
            extra: RegistrationType.instructor,
          );
        } else {
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
        }
      },
    );
  }
}

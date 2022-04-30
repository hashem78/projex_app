import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOutTile extends StatelessWidget {
  const SignOutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
      },
      leading: const Icon(Icons.logout),
      title: const Text('Sign out'),
    );
  }
}

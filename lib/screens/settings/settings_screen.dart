import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
          )
        ],
      ),
    );
  }
}

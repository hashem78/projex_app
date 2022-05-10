import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:projex_app/screens/profile/widgets/profile_screen_image.dart';
import 'package:projex_app/state/auth.dart';
import 'package:projex_app/state/locale.dart';

class PDrawer extends ConsumerWidget {
  const PDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations;
    final user = ref.watch(authProvider)!;
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              context.go('/profile');
            },
            child: UserAccountsDrawerHeader(
              currentAccountPicture: const ProfileScreenImage(
                borderWidth: 2,
              ),
              accountName: Text(user.name),
              accountEmail: Text(user.email),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(translations.settings.name),
            onTap: () {
              context.goNamed('settings');
            },
          ),
        ],
      ),
    );
  }
}

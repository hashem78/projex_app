import 'package:flutter/material.dart';
import 'package:projex_app/screens/settings/widgets/signout_tile.dart';
import 'package:projex_app/screens/settings/widgets/theme_mode/theme_mode_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const [
          ThemeModeTile(),
          SignOutTile(),
        ],
      ),
    );
  }
}

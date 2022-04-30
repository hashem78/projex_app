import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/settings/widgets/signout_tile.dart';
import 'package:projex_app/screens/settings/widgets/theme_mode/theme_mode_tile.dart';
import 'package:projex_app/screens/settings/widgets/translations/translations_tile.dart';
import 'package:projex_app/state/locale.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.settings.name),
      ),
      body: ListView(
        children: const [
          ThemeModeTile(),
          TranslationsTile(),
          SignOutTile(),
        ],
      ),
    );
  }
}

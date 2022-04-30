import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/settings/widgets/theme_mode/theme_mode_change_dialog.dart';
import 'package:projex_app/state/theme_mode.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class ThemeModeTile extends ConsumerWidget {
  const ThemeModeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeModeProvider);
    return ListTile(
      leading: const Icon(Icons.colorize),
      title: const Text("Theme Mode"),
      subtitle: Text(toBeginningOfSentenceCase(themeState.themeMode.name)!),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const ChangeThemeDialog(),
        );
      },
    );
  }
}

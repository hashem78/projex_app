import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/ui/theme_mode/theme_mode.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/theme_mode.dart';

class ChangeThemeDialog extends ConsumerWidget {
  const ChangeThemeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeModeProvider);
    final translations = ref.watch(translationProvider).translations;

    return AlertDialog(
      title: Text(translations.settings.chooseThemeTitle),
      actions: [
        RadioListTile<PThemeMode>(
          value: const PThemeMode.system(),
          groupValue: themeState,
          title: Text(translations.settings.themeSystem),
          onChanged: (val) async {
            if (val != null) {
              final notifier = ref.read(themeModeProvider.notifier);
              await notifier.chageTo(val);
            }
          },
        ),
        RadioListTile<PThemeMode>(
          value: const PThemeMode.light(),
          groupValue: themeState,
          title: Text(translations.settings.themeLight),
          onChanged: (val) async {
            if (val != null) {
              final notifier = ref.read(themeModeProvider.notifier);
              await notifier.chageTo(val);
            }
          },
        ),
        RadioListTile<PThemeMode>(
          value: const PThemeMode.dark(),
          groupValue: themeState,
          title: Text(translations.settings.themeDark),
          onChanged: (val) async {
            if (val != null) {
              final notifier = ref.read(themeModeProvider.notifier);
              await notifier.chageTo(val);
            }
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/ui/theme_mode/theme_mode.dart';
import 'package:projex_app/state/theme_mode.dart';

class ChangeThemeDialog extends ConsumerWidget {
  const ChangeThemeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeModeProvider);

    return AlertDialog(
      title: const Text("Change Theme Mode"),
      actions: [
        RadioListTile<PThemeMode>(
          value: systemTheme,
          groupValue: themeState,
          title: const Text("System"),
          onChanged: (_) async {
            final notifier = ref.read(themeModeProvider.notifier);
            await notifier.chageToSystem();
          },
        ),
        RadioListTile<PThemeMode>(
          value: kLightTheme,
          groupValue: themeState,
          title: const Text("Light"),
          onChanged: (_) async {
            final notifier = ref.read(themeModeProvider.notifier);
            await notifier.chageToLight();
          },
        ),
        RadioListTile<PThemeMode>(
          value: kDarkTheme,
          groupValue: themeState,
          title: const Text("Dark"),
          onChanged: (themeMode) async {
            final notifier = ref.read(themeModeProvider.notifier);
            await notifier.chageToDark();
          },
        ),
      ],
    );
  }
}

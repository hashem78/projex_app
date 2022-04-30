import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/settings/widgets/theme_mode/theme_mode_change_dialog.dart';
import 'package:projex_app/state/locale.dart';
import 'package:projex_app/state/theme_mode.dart';

class ThemeModeTile extends ConsumerWidget {
  const ThemeModeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late String subTitle;
    final themeState = ref.watch(themeModeProvider);
    final translations = ref.watch(translationProvider).translations;
    if (themeState == kLightTheme) {
      subTitle = translations.settings.themeLight;
    } else if (themeState == kDarkTheme) {
      subTitle = translations.settings.themeDark;
    } else {
      subTitle = translations.settings.themeSystem;
    }
    return ListTile(
      leading: const Icon(Icons.colorize),
      title: Text(translations.settings.themeTitle),
      subtitle: Text(subTitle),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const ChangeThemeDialog(),
        );
      },
    );
  }
}

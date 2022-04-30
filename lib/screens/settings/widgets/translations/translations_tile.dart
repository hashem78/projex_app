import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/i18n/translations.g.dart';
import 'package:projex_app/screens/settings/widgets/translations/translations_change_dialog.dart';
import 'package:projex_app/state/locale.dart';

class TranslationsTile extends ConsumerWidget {
  const TranslationsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider.select(
      (value) => value.translations,
    ));
    final locale = ref.watch(
      translationProvider.select((value) => value.locale),
    );
    late String subTitle;
    switch (locale) {
      case AppLocale.en:
        subTitle = translations.settings.languageEnglish;
        break;
      case AppLocale.ar:
        subTitle = translations.settings.languageArabic;

        break;
    }

    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(translations.settings.languageTitle),
      subtitle: Text(subTitle),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const TranslationsChangeDialog(),
        );
      },
    );
  }
}

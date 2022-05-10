import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/i18n/translations.g.dart';
import 'package:projex_app/state/locale.dart';

class TranslationsChangeDialog extends ConsumerWidget {
  const TranslationsChangeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(
      translationProvider.select((value) => value.locale),
    );
    final translations = ref.watch(
      translationProvider.select((value) => value.translations),
    );

    return AlertDialog(
      title: Text(translations.settings.chooseLanguageTitle),
      actions: [
        RadioListTile<AppLocale>(
          value: AppLocale.en,
          title: Text(translations.settings.languageEnglish),
          groupValue: locale,
          onChanged: (val) {
            if (val != null) {
              ref.read(translationProvider.notifier).setTranslations(val);
            }
          },
        ),
        RadioListTile<AppLocale>(
          value: AppLocale.ar,
          title: Text(translations.settings.languageArabic),
          groupValue: locale,
          onChanged: (val) {
            if (val != null) {
              ref.read(translationProvider.notifier).setTranslations(val);
            }
          },
        ),
      ],
    );
  }
}

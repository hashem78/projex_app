import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/locale.dart';

class CompeleteRegistrationTitle extends ConsumerWidget {
  const CompeleteRegistrationTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations =
        ref.watch(translationProvider).translations.registration;
    return Text(
      translations.registrationScreenTitle,
      style: Theme.of(context).textTheme.headline4,
      textAlign: TextAlign.center,
    );
  }
}

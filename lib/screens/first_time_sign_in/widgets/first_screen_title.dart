import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/state/locale.dart';

class FirstTimeScreenTitle extends ConsumerWidget {
  const FirstTimeScreenTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations;
    return Text(
      translations.login.firstTimeTitle,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

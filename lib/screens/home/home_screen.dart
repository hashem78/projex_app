import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/screens/home/widgets/drawer.dart';
import 'package:projex_app/state/locale.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.home.appBarTitle),
      ),
      drawer: const PDrawer(),
    );
  }
}

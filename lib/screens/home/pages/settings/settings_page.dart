import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projex_app/screens/home/pages/settings/widgets/signout_tile.dart';
import 'package:projex_app/screens/home/pages/settings/widgets/theme_mode/theme_mode_tile.dart';
import 'package:projex_app/screens/home/pages/settings/widgets/translations/translations_tile.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 0.25.sh,
          backgroundColor: Colors.teal,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Settings'),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const ThemeModeTile(),
              const TranslationsTile(),
              const SignOutTile(),
            ],
          ),
        ),
      ],
    );
  }
}

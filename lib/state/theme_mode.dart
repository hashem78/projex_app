import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/ui/theme_mode/theme_mode.dart';
import 'package:projex_app/state/shared_perferences_provider.dart';

/// Light theme instance
const kLightTheme = PThemeMode(
  brightness: Brightness.light,
  themeMode: ThemeMode.light,
);

/// Dark theme instance
const kDarkTheme = PThemeMode(
  brightness: Brightness.dark,
  themeMode: ThemeMode.dark,
);

/// System Theme instance
final systemTheme = PThemeMode(
  brightness: SchedulerBinding.instance!.window.platformBrightness,
  themeMode: ThemeMode.system,
);

/// Notifier for thememode chagnes, after every state change
/// we persist to SharedPereferences.
class PThemeModeNotifier extends StateNotifier<PThemeMode> {
  /// To be able to access the SharedPereferences instance
  final Ref ref;

  PThemeModeNotifier(PThemeMode state, this.ref) : super(state);

  Future<void> chageTo(PThemeMode other) async {
    state = other;
    final prefs = ref.read(sharedPerferencesProvider);
    await prefs.setString('themeMode', jsonEncode(state));
  }
}

/// Provides the widget tree with the current theme, initially we load the current
/// theme type from storage then pass it to the notifier.
final themeModeProvider = StateNotifierProvider<PThemeModeNotifier, PThemeMode>(
  (ref) {
    final prefs = ref.read(sharedPerferencesProvider);
    if (prefs.containsKey("themeMode")) {
      final state = jsonDecode(prefs.getString("themeMode")!);
      return PThemeModeNotifier(PThemeMode.fromJson(state), ref);
    } else {
      final platformBrightness =
          SchedulerBinding.instance!.window.platformBrightness;
      final state = PThemeMode(
        brightness: platformBrightness,
        themeMode: ThemeMode.system,
      );
      prefs.setString("themeMode", jsonEncode(state));
      return PThemeModeNotifier(state, ref);
    }
  },
);

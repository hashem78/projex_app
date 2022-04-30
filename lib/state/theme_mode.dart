import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/ui/theme_mode/theme_mode.dart';
import 'package:projex_app/state/shared_perferences_provider.dart';

const kLightTheme = PThemeMode(
  brightness: Brightness.light,
  themeMode: ThemeMode.light,
);
const kDarkTheme = PThemeMode(
  brightness: Brightness.dark,
  themeMode: ThemeMode.dark,
);
final systemTheme = PThemeMode(
  brightness: SchedulerBinding.instance!.window.platformBrightness,
  themeMode: ThemeMode.system,
);

class PThemeModeNotifier extends StateNotifier<PThemeMode> {
  final Ref ref;
  PThemeModeNotifier(PThemeMode state, this.ref) : super(state);
  Future<void> chageToLight() async {
    state = kLightTheme;
    final prefs = ref.read(sharedPerferencesProvider);
    await prefs.setString('themeMode', jsonEncode(state));
  }

  Future<void> chageToDark() async {
    state = kDarkTheme;
    final prefs = ref.read(sharedPerferencesProvider);
    await prefs.setString('themeMode', jsonEncode(state));
  }

  Future<void> chageToSystem() async {
    state = systemTheme;
    final prefs = ref.read(sharedPerferencesProvider);
    await prefs.setString('themeMode', jsonEncode(state));
  }
}

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

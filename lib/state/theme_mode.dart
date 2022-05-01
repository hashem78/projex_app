import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projex_app/models/ui/theme_mode/theme_mode.dart';
import 'package:projex_app/state/shared_perferences_provider.dart';

/// Notifier for thememode chagnes, after every state change
/// we persist to SharedPereferences.
class PThemeModeNotifier extends StateNotifier<PThemeMode> {
  /// To be able to access the SharedPereferences instance
  final Ref _ref;
  void handleSystemTheme() {
    final window = WidgetsBinding.instance!.window;
    window.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance?.handlePlatformBrightnessChanged();
      // We ignore the const here because const instances are all the same
      // And since rebuilds happen on state changes, the new state has to be
      // non const for a rebuild to happen.
      // ignore: prefer_const_constructors
      state = PThemeMode.system();
    };
  }

  void handleDarkAndLightThemes() {
    final window = WidgetsBinding.instance!.window;
    window.onPlatformBrightnessChanged =
        WidgetsBinding.instance?.handlePlatformBrightnessChanged;
  }

  PThemeModeNotifier(PThemeMode state, this._ref) : super(state) {
    // Registers the platform change handeler if the initial state
    // is PThememode.system
    state.whenOrNull(
      system: handleSystemTheme,
    );
  }

  Future<void> chageTo(PThemeMode other) async {
    state = other;
    state.when(
      system: handleSystemTheme,
      light: handleDarkAndLightThemes,
      dark: handleDarkAndLightThemes,
    );
    final prefs = _ref.read(sharedPerferencesProvider);
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
      const state = PThemeMode.system();
      prefs.setString("themeMode", jsonEncode(state));
      return PThemeModeNotifier(state, ref);
    }
  },
);

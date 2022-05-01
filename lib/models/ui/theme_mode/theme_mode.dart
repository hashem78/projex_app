import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'theme_mode.freezed.dart';
part 'theme_mode.g.dart';

@freezed
class PThemeMode with _$PThemeMode {
  const PThemeMode._();

  @JsonKey(ignore: true)
  ThemeMode get flutterThemeMode => when(
        system: () => ThemeMode.system,
        light: () => ThemeMode.light,
        dark: () => ThemeMode.dark,
      );
  @JsonKey(ignore: true)
  Brightness get flutterBrightness => when(
        system: () => SchedulerBinding.instance!.window.platformBrightness,
        light: () => Brightness.light,
        dark: () => Brightness.dark,
      );
  const factory PThemeMode.system() = _PThemeModeSystem;
  const factory PThemeMode.light() = _PThemeModeLight;
  const factory PThemeMode.dark() = _PThemeModeDark;

  factory PThemeMode.fromJson(Map<String, dynamic> json) =>
      _$PThemeModeFromJson(json);
}

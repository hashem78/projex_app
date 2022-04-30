import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'theme_mode.freezed.dart';
part 'theme_mode.g.dart';

@freezed
class PThemeMode with _$PThemeMode {
  const factory PThemeMode({
    required ThemeMode themeMode,
    required Brightness brightness,
  }) = _PThemeMode;
  factory PThemeMode.fromJson(Map<String, dynamic> json) =>
      _$PThemeModeFromJson(json);
}

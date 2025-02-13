import 'package:flutter/material.dart';

sealed class ThemeSettingsState {}

class ThemeSettingsInitial extends ThemeSettingsState {}

class ThemeSettingsLoading extends ThemeSettingsState {}

class ThemeSettingsSuccess extends ThemeSettingsState {
  final ThemeData theme;
  final ThemeData darkTheme;

  ThemeSettingsSuccess({required this.theme, required this.darkTheme});
}

class ThemeSettingsError extends ThemeSettingsState {
  final String error;

  ThemeSettingsError({required this.error});
}

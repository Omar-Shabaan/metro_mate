
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  SettingsState({
    required this.themeMode,
    required this.locale,
  });
}

class SettingsCubit extends Cubit<SettingsState> {
  Box get settingsBox => Hive.box('SettingsBox');

  SettingsCubit()
      : super(
          SettingsState(
            themeMode: _getTheme(),
            locale: _getLocale(),
          ),
        );

  static ThemeMode _getTheme() {
    final value = Hive.box('SettingsBox').get(
      'themeMode',
      defaultValue: 'system',
    );

    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  static Locale _getLocale() {
    final value = Hive.box('SettingsBox').get(
      'locale',
      defaultValue: 'ar',
    );

    return Locale(value);
  }

  void toggleTheme() {
    final newTheme = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    emit(
      SettingsState(
        themeMode: newTheme,
        locale: state.locale,
      ),
    );

    settingsBox.put('themeMode', newTheme.name);
  }

  void toggleLanguage() {
    final newLocale = state.locale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar');

    emit(
      SettingsState(
        themeMode: state.themeMode,
        locale: newLocale,
      ),
    );

    settingsBox.put('locale', newLocale.languageCode);
  }
}

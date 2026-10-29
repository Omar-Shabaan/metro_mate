import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  SettingsState({required this.themeMode, required this.locale});
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          themeMode: ThemeMode.system,
          locale: const Locale('ar'),
        ));

  void toggleTheme() {
    final isDark = state.themeMode == ThemeMode.dark;
    emit(SettingsState(
      themeMode: isDark ? ThemeMode.light : ThemeMode.dark,
      locale: state.locale,
    ));
  }

  void toggleLanguage() {
    final isArabic = state.locale.languageCode == 'ar';
    emit(SettingsState(
      themeMode: state.themeMode,
      locale: isArabic ? const Locale('en') : const Locale('ar'),
    ));
  }
}
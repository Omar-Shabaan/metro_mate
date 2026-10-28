import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextStyle _style(
    bool arabic,
    double size,
    FontWeight weight,
    Color color,
  ) {
    final height = arabic ? 1.5 : 1.4;
    if (arabic) {
      return GoogleFonts.cairo(
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color,
      );
    }
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      height: height,
      color: color,
    );
  }

  static TextTheme build({required bool arabic, required bool dark}) {
    final primary = dark ? AppColors.textOnDark : AppColors.textPrimary;
    final secondary =
        dark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    TextStyle s(double size, FontWeight weight, [Color? color]) =>
        _style(arabic, size, weight, color ?? primary);

    return TextTheme(
      displayLarge: s(34, FontWeight.w700),
      displayMedium: s(28, FontWeight.w700),
      displaySmall: s(26, FontWeight.w700),
      headlineLarge: s(22, FontWeight.w700),
      headlineMedium: s(20, FontWeight.w700),
      headlineSmall: s(18, FontWeight.w700),
      titleLarge: s(16, FontWeight.w600),
      titleMedium: s(15, FontWeight.w600),
      titleSmall: s(14, FontWeight.w600),
      bodyLarge: s(14, FontWeight.w400),
      bodyMedium: s(13, FontWeight.w400),
      bodySmall: s(12, FontWeight.w400, secondary),
      labelLarge: s(14, FontWeight.w600),
      labelMedium: s(12, FontWeight.w600),
      labelSmall: s(10, FontWeight.w600),
    );
  }

  static final TextTheme light = build(arabic: false, dark: false);
  static final TextTheme dark = build(arabic: false, dark: true);
  static final TextTheme lightArabic = build(arabic: true, dark: false);
  static final TextTheme darkArabic = build(arabic: true, dark: true);
}
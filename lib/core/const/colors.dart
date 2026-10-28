import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1E5BC6);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color active = Color(0xFF82B0FF);

  static const Color background = Color(0xFFF7F9FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF4F7FD);
  static const Color primaryLight = Color(0xFFEDF3FD);
  static const Color border = Color(0xFFE3E9F1);

  static const Color darkest = Color(0xFF0F1B33);
  static const Color dark = Color(0xFF091222);
  static const Color darkSurface = Color(0xFF14223A);
  static const Color darkGreen = Color(0xFF1D2E49);
  static const Color forest = Color(0xFF2B3C56);

  static const Color textPrimary = Color(0xFF0F1B33);
  static const Color textSecondary = Color(0xFF64718A);
  static const Color textHint = Color(0xFFACBAD0);
  static const Color textOnDark = Color(0xFFF4F7FD);
  static const Color darkTextSecondary = Color(0xFFACBAD0);
  static const Color darkTextHint = Color(0xFF8290A5);

  static const Color success = Color(0xFF2E9E5B);
  static const Color warning = Color(0xFFFFB300);
  static const Color orange = Color(0xFFFB8C00);
  static const Color amberDark = Color(0xFF8A5A00);
  static const Color error = Color(0xFFE53935);

  static const Color line1 = Color(0xFF1E5BC6);
  static const Color line2 = Color(0xFFE53935);
  static const Color line3 = Color(0xFF2E9E5B);
  static const Color line4 = Color(0xFF7B3FBF);

  static const Color mapWater = Color(0xFFC8E8F4);
  static const Color mapWaterDark = Color(0xFF173C54);
  static const Color mapCanvas = Color(0xFFEDF2F6);
  static const Color mapCanvasDark = Color(0xFF101E31);

  static Color line(int number) {
    switch (number) {
      case 1:
        return line1;
      case 2:
        return line2;
      case 3:
        return line3;
      default:
        return line4;
    }
  }

  static const Color primaryTint = Color(0x1F1E5BC6);
  static const Color successTint = Color(0x1A2E9E5B);
  static const Color warningTint = Color(0x26FFB300);
  static const Color errorTint = Color(0x1AE53935);
  static const Color whiteTint = Color(0x24FFFFFF);
  static const Color darkOverlay = Color(0xA80F1B33);

  static const LinearGradient imageOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x000F1B33), Color(0xE60F1B33)],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF1E5BC6), Color(0xFF3B82F6)],
  );
}
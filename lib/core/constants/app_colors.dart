import 'package:flutter/material.dart';

/// Centralized color palette for SwiftShare AI.
/// Dark, modern aesthetic with an electric blue -> violet gradient accent.
class AppColors {
  AppColors._();

  // Base surfaces
  static const Color background = Color(0xFF0A0E17);
  static const Color surface = Color(0xFF121826);
  static const Color surfaceElevated = Color(0xFF1A2233);
  static const Color surfaceBorder = Color(0xFF232C40);

  // Accent gradient
  static const Color accentStart = Color(0xFF3D8BFF);
  static const Color accentEnd = Color(0xFF8A5CFF);
  static const Color accentSoft = Color(0xFF6E7BFF);

  // Status colors
  static const Color success = Color(0xFF33D69F);
  static const Color warning = Color(0xFFFFB84D);
  static const Color error = Color(0xFFFF5C7A);
  static const Color info = Color(0xFF4DC8FF);

  // Text colors
  static const Color textPrimary = Color(0xFFF5F7FA);
  static const Color textSecondary = Color(0xFFA0AABF);
  static const Color textMuted = Color(0xFF5E6B85);

  // Utility
  static const Color divider = Color(0xFF1F2836);
  static const Color shadow = Color(0x66000000);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentStart, accentEnd],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surfaceElevated, surface],
  );

  static const RadialGradient scanGlow = RadialGradient(
    colors: [Color(0x553D8BFF), Color(0x00000000)],
  );
}

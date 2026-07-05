import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimens.dart';

/// Central ThemeData for SwiftShare AI. Only one theme (dark) exists for
/// Phase 1 — a light theme toggle can be layered on later via the
/// themeProvider without touching screen code.
class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTextStyles.fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentStart,
        secondary: AppColors.accentEnd,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.h3,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      splashColor: AppColors.accentSoft.withOpacity(0.08),
      highlightColor: Colors.transparent,
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.h1,
        headlineMedium: AppTextStyles.h2,
        headlineSmall: AppTextStyles.h3,
        bodyMedium: AppTextStyles.body,
        bodyLarge: AppTextStyles.bodyStrong,
        labelLarge: AppTextStyles.button,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentStart,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(AppDimens.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size.fromHeight(AppDimens.buttonHeight),
          side: const BorderSide(color: AppColors.surfaceBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accentStart;
          }
          return AppColors.surfaceBorder;
        }),
      ),
    );
  }
}

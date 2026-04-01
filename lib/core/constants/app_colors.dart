import 'package:flutter/material.dart';

/// Uygulama tema ve renk sabitleri.
class AppColors {
  AppColors._();

  // Ana renkler
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF4A42E8);
  static const Color primaryLight = Color(0xFF9D97FF);

  // ── Dark tema arka plan renkleri ──
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E2C);
  static const Color cardDark = Color(0xFF252540);

  // ── Light tema arka plan renkleri ──
  static const Color backgroundLight = Color(0xFFF5F5FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFEEEEF5);

  // ── Dark tema metin renkleri ──
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0C3);
  static const Color textHint = Color(0xFF6E6E82);

  // ── Light tema metin renkleri ──
  static const Color textPrimaryLight = Color(0xFF1C1C2E);
  static const Color textSecondaryLight = Color(0xFF5A5A72);
  static const Color textHintLight = Color(0xFF9E9EB0);

  // Durum renkleri
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Alarm renkleri
  static const Color alarmActive = Color(0xFF6C63FF);
  static const Color alarmInactive = Color(0xFF3A3A4F);
  static const Color snoozeColor = Color(0xFFFF9800);
}

/// Tema-duyarlı özel renkler için ThemeExtension.
/// UI dosyalarında `AppColorsExtension.of(context)` ile erişilir.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color background;
  final Color surface;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;

  const AppColorsExtension({
    required this.background,
    required this.surface,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
  });

  /// Dark tema renkleri.
  static const dark = AppColorsExtension(
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    card: AppColors.cardDark,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textHint: AppColors.textHint,
  );

  /// Light tema renkleri.
  static const light = AppColorsExtension(
    background: AppColors.backgroundLight,
    surface: AppColors.surfaceLight,
    card: AppColors.cardLight,
    textPrimary: AppColors.textPrimaryLight,
    textSecondary: AppColors.textSecondaryLight,
    textHint: AppColors.textHintLight,
  );

  /// Kısayol — context'ten extension'a eriş.
  static AppColorsExtension of(BuildContext context) {
    return Theme.of(context).extension<AppColorsExtension>()!;
  }

  @override
  AppColorsExtension copyWith({
    Color? background,
    Color? surface,
    Color? card,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
    );
  }
}

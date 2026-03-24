import 'package:flutter/material.dart';

/// Uygulama tema ve renk sabitleri.
class AppColors {
  AppColors._();

  // Ana renkler
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF4A42E8);
  static const Color primaryLight = Color(0xFF9D97FF);

  // Arka plan renkleri
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E2C);
  static const Color cardDark = Color(0xFF252540);

  // Metin renkleri
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0C3);
  static const Color textHint = Color(0xFF6E6E82);

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

import 'package:flutter/material.dart';

/// All the custom colors used throughout the app.
abstract class AppColors {
  // Primary brand color
  static const Color primary = Color(0xFF1565C0);

  // Accent / secondary color
  static const Color accent = Color(0xFFFFC107);

  // Backgrounds
  static const Color scaffoldBackground = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  // Error
  static const Color error = Color(0xFFD32F2F);

  // Hint / disabled
  static const Color hint = Color(0xFF9E9E9E);
}

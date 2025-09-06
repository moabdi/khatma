import 'package:flutter/material.dart';
import 'package:khatma_ui/extentions/color_extensions.dart';

/// Centralized color definitions following Material Design 3
class AppColors {
  AppColors._();

  // Brand Colors - Islamic theme
  static final Color primaryGreen = HexColor("#00A862");
  static final Color secondaryOrange = HexColor("#C66628");

  // Material Design 3 Color Tokens
  static const Color neutral0 = Color(0xFF000000);
  static const Color neutral10 = Color(0xFF1C1B1F);
  static const Color neutral20 = Color(0xFF313033);
  static const Color neutral90 = Color(0xFFE6E0E9);
  static const Color neutral95 = Color(0xFFF4EFF4);
  static const Color neutral99 = Color(0xFFFFFBFA);
  static const Color neutral100 = Color(0xFFFFFFFF);

  // Semantic colors with proper contrast
  static const Color success = Color(0xFF00C851);
  static const Color warning = Color(0xFFFF8800);
  static const Color error = Color(0xFFBA1A1A);
  static const Color info = Color(0xFF2196F3);

  // Surface colors for M3
  static const Color surfaceLight = Color(0xFFFEF7FF);
  static const Color surfaceDark = Color(0xFF141218);

  /// Generate color variations
  static Color lighten(Color color, double factor) {
    return Color.lerp(color, neutral100, factor.clamp(0.0, 1.0)) ?? color;
  }

  static Color darken(Color color, double factor) {
    return Color.lerp(color, neutral0, factor.clamp(0.0, 1.0)) ?? color;
  }
}

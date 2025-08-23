import 'package:flutter/material.dart';

/// Material Design 3 compliant typography
class AppTextTheme {
  AppTextTheme._();

  // Font families
  static const String _displayFontFamily = 'Airbnb'; // Your existing font
  static const String _bodyFontFamily = 'Lato'; // Your existing font

  /// Generate text theme based on color scheme
  static TextTheme textTheme(ColorScheme colorScheme) {
    final Color onSurface = colorScheme.onSurface;
    final Color onSurfaceVariant = colorScheme.onSurfaceVariant;

    return TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontFamily: _displayFontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: onSurface,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontFamily: _displayFontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: onSurface,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontFamily: _displayFontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: onSurface,
        height: 1.22,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: _displayFontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: onSurface,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontFamily: _displayFontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: onSurface,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontFamily: _displayFontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: onSurface,
        height: 1.33,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: _displayFontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: onSurface,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontFamily: _bodyFontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: onSurface,
        height: 1.50,
      ),
      titleSmall: TextStyle(
        fontFamily: _bodyFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: onSurface,
        height: 1.43,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontFamily: _bodyFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: onSurface,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontFamily: _bodyFontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: onSurface,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontFamily: _bodyFontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: onSurface,
        height: 1.45,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontFamily: _bodyFontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: onSurface,
        height: 1.50,
      ),
      bodyMedium: TextStyle(
        fontFamily: _bodyFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: onSurface,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontFamily: _bodyFontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: onSurfaceVariant,
        height: 1.33,
      ),
    );
  }
}

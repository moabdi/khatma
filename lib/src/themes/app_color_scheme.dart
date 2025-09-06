import 'package:flutter/material.dart';

/// Material Design 3 compliant color schemes
class AppColorScheme {
  AppColorScheme._();

  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,

    // Primary colors
    primary: Color(0xFF00A862),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF4CAF50),
    onPrimaryContainer: Color(0xFF00693E),

    // Secondary colors
    secondary: Color(0xFFC66628),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFE0B2),
    onSecondaryContainer: Color(0xFFBF360C),

    // Tertiary colors (Quran gold)
    tertiary: Color(0xFFD4AF37),
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFFFFF8DC),
    onTertiaryContainer: Color(0xFF8B7355),

    // Error colors
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    // Surface colors
    surface: Color(0xFFFEF7FF),
    onSurface: Color(0xFF1C1B1F),
    onSurfaceVariant: Color(0xFF49454F),

    // Outline colors
    outline: Color(0xFF79747E),
    outlineVariant: Color(0xFFCAC4D0),

    // Other required colors
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF313033),
    onInverseSurface: Color(0xFFF4EFF4),
    inversePrimary: Color(0xFF4CAF50),

    // Surface container variants
    surfaceDim: Color(0xFFDDD8E0),
    surfaceBright: Color(0xFFFEF7FF),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF7F2FA),
    surfaceContainer: Color(0xFFF1ECF4),
    surfaceContainerHigh: Color(0xFFECE6F0),
    surfaceContainerHighest: Color(0xFFE6E0E9),
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,

    // Primary colors (lighter for dark theme)
    primary: Color(0xFF00A862),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF00A862),
    onPrimaryContainer: Color(0xFFB8F5CD),

    // Secondary colors
    secondary: Color(0xFFFF9800),
    onSecondary: Color(0xFFBF360C),
    secondaryContainer: Color(0xFFC66628),
    onSecondaryContainer: Color(0xFFFFE0B2),

    // Tertiary colors
    tertiary: Color(0xFFFFF8DC),
    onTertiary: Color(0xFF8B7355),
    tertiaryContainer: Color(0xFFD4AF37),
    onTertiaryContainer: Color(0xFFFFF8DC),

    // Error colors
    error: Color(0xFFBA1A1A),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    // Surface colors
    surface: Color(0xFF141218),
    onSurface: Color(0xFFE6E0E9),
    onSurfaceVariant: Color(0xFFCAC4D0),

    // Outline colors
    outline: Color(0xFF938F99),
    outlineVariant: Color(0xFF49454F),

    // Other required colors
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFE6E0E9),
    onInverseSurface: Color(0xFF313033),
    inversePrimary: Color(0xFF00A862),

    // Surface container variants
    surfaceDim: Color(0xFF141218),
    surfaceBright: Color(0xFF3A3842),
    surfaceContainerLowest: Color(0xFF0F0D13),
    surfaceContainerLow: Color(0xFF1C1B1F),
    surfaceContainer: Color(0xFF201F23),
    surfaceContainerHigh: Color(0xFF2B292D),
    surfaceContainerHighest: Color(0xFF363438),
  );
}

import 'package:flutter/material.dart';

/// Material Design 3 compliant color schemes
class AppColorScheme {
  AppColorScheme._();

  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,

    // Primary colors (Green from design system)
    primary: Color(0xFF059669), // Darker green for better contrast
    onPrimary: Color(0xFFFFFFFF), // White on primary
    primaryContainer: Color(0xFFD1FAE5), // Light green container
    onPrimaryContainer: Color(0xFF065F46), // Very dark green on container

    // Secondary colors (Blue from design system)
    secondary: Color(0xFF2563EB), // Darker blue for better contrast
    onSecondary: Color(0xFFFFFFFF), // White on secondary
    secondaryContainer: Color(0xFFDBEAFE), // Light blue container
    onSecondaryContainer: Color(0xFF1E40AF), // Dark blue on container

    // Tertiary colors (Cyan/Info from design system)
    tertiary: Color(0xFF0891B2), // Darker cyan for better contrast
    onTertiary: Color(0xFFFFFFFF), // White on tertiary
    tertiaryContainer: Color(0xFFCFFAFE), // Light cyan container
    onTertiaryContainer: Color(0xFF164E63), // Very dark cyan on container

    // Error colors (Red from design system)
    error: Color(0xFFDC2626), // Darker red for better contrast
    onError: Color(0xFFFFFFFF), // White on error
    errorContainer: Color(0xFFFEE2E2), // Light red container
    onErrorContainer: Color(0xFF991B1B), // Dark red on container

    // Surface colors (Grey scale from design system)
    surface: Color(0xFFFFFFFF), // Pure white for maximum contrast
    onSurface: Color(0xFF111827), // Grey 900 - very dark text
    onSurfaceVariant: Color(0xFF4B5563), // Grey 600 - darker variant text

    // Outline colors
    outline: Color(0xFF9CA3AF), // Grey 400 - darker outline
    outlineVariant: Color(0xFFD1D5DB), // Grey 300

    // Other required colors
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF1F2937), // Grey 800
    onInverseSurface: Color(0xFFF9FAFB), // Grey 50
    inversePrimary: Color(0xFF10B981), // Bright green

    // Surface container variants
    surfaceDim: Color(0xFFD1D5DB), // Grey 300 - darker dim surface
    surfaceBright: Color(0xFFFFFFFF), // White
    surfaceContainerLowest: Color(0xFFFFFFFF), // White
    surfaceContainerLow: Color(0xFFF9FAFB), // Grey 50
    surfaceContainer: Color(0xFFF3F4F6), // Grey 100
    surfaceContainerHigh: Color(0xFFE5E7EB), // Grey 200
    surfaceContainerHighest: Color(0xFFD1D5DB), // Grey 300
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,

    // Primary colors (Green from design system)
    primary: Color(0xFF10B981), // Primary green
    onPrimary: Color(0xFF111827), // Grey 900 on primary
    primaryContainer: Color(0xFF047857), // Dark green container
    onPrimaryContainer: Color(0xFFD1FAE5), // Light green on container

    // Secondary colors (Blue from design system)
    secondary: Color(0xFF3B82F6), // Secondary blue
    onSecondary: Color(0xFF111827), // Grey 900 on secondary
    secondaryContainer: Color(0xFF1E40AF), // Dark blue container
    onSecondaryContainer: Color(0xFFDCEEFF), // Light blue on container

    // Tertiary colors (Cyan/Info from design system)
    tertiary: Color(0xFF06B6D4), // Cyan/Info
    onTertiary: Color(0xFF111827), // Grey 900 on tertiary
    tertiaryContainer: Color(0xFF0E7490), // Dark cyan container
    onTertiaryContainer: Color(0xFFCFFAFE), // Light cyan on container

    // Error colors (Red from design system)
    error: Color(0xFFEF4444), // Error red
    onError: Color(0xFF111827), // Grey 900 on error
    errorContainer: Color(0xFF991B1B), // Dark red container
    onErrorContainer: Color(0xFFFEE2E2), // Light red on container

    // Surface colors (Grey scale from design system)
    surface: Color(0xFF111827), // Grey 900
    onSurface: Color(0xFFF9FAFB), // Grey 50
    onSurfaceVariant: Color(0xFF9CA3AF), // Grey 400

    // Outline colors
    outline: Color(0xFF4B5563), // Grey 600
    outlineVariant: Color(0xFF374151), // Grey 700

    // Other required colors
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFF9FAFB), // Grey 50
    onInverseSurface: Color(0xFF1F2937), // Grey 800
    inversePrimary: Color(0xFF047857), // Dark green

    // Surface container variants
    surfaceDim: Color(0xFF111827), // Grey 900
    surfaceBright: Color(0xFF374151), // Grey 700
    surfaceContainerLowest: Color(0xFF0F1419), // Darker than Grey 900
    surfaceContainerLow: Color(0xFF1F2937), // Grey 800
    surfaceContainer: Color(0xFF252D3A), // Between Grey 800 and 700
    surfaceContainerHigh: Color(0xFF2D3748), // Slightly lighter
    surfaceContainerHighest: Color(0xFF374151), // Grey 700
  );
}
